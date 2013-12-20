require 'highline/import'

class Hash
  def dig(array)
    if array.size > 0
      key = array.shift
      match = self[key]
      if array.size > 0
        return match.dig(array)
      else
        return match
      end
    else
      return self
    end
  end
end

module Dinar
  class Translation

    def initialize source_locale, target_locale
      @source_locale, @target_locale = source_locale, target_locale
    end

    def run
      master_locales = Dir["#{Rails.root}/config/locales/#{@source_locale}/**/*.yml"].map do |file|
        file.match(/\/config\/locales\/\w{2}\/([\w\.]*)\.\w{2}\.yml/)[1]
      end

      target_locales = Dir["#{Rails.root}/config/locales/#{@target_locale}/**/*.yml"].map do |file|
        file.match(/\/config\/locales\/\w{2}\/([\w\.]*)\.\w{2}\.yml/)[1]
      end

      HashDiff.diff(target_locales,master_locales).each do |diff|
        file = "#{@target_locale}/#{diff[2]}.#{@target_locale}.yml"
        case diff[0]
          when '+'
            if agree("create missing file #{file}? (y,n) ")
              hash = Hash.new
              hash[@target_locale] = {}
              File.open("#{Rails.root}/config/locales/#{file}",'w+') {|f| f.write(hash.to_yaml) }
            end
          when '-'
            if agree("delete obsolete file #{file}? (y,n) ")
              File.delete("#{Rails.root}/config/locales/#{file}")
            end
        end
      end

      master_locales.each do |locale_file|
        master_file = File.expand_path("#{Rails.root}/config/locales/#{@source_locale}/#{locale_file}.#{@source_locale}.yml")
        target_file = File.expand_path("#{Rails.root}/config/locales/#{@target_locale}/#{locale_file}.#{@target_locale}.yml")

        master_hash = YAML.load(File.read(master_file))
        target_hash = YAML.load(File.read(target_file))

        diff = HashDiff.diff(target_hash[@target_locale],master_hash[@source_locale])
        diff = diff.select{ |e| !e[0].eql?('~') }

        while diff.size > 0
          diff.each do |diff|
            dot_id = diff[1].dup
            elements = dot_id.split('.')
            last = elements.pop
            key = [@target_locale,*elements,last].join('.')
            case diff[0]
              when '+'
                if master_hash.dig([@source_locale,*elements,last]).is_a? Hash
                  puts "added hash for key '#{key}'"
                  target_hash[target_locale].dig(elements)[last] = {}
                  next
                end
                begin
                  master = master_hash[@source_locale].dig([*elements,last])
                  val = ask("value for missing key '#{key}' (#{master}): ")
                rescue Interrupt => e
                  File.open(target_file,'w+') {|f| f.write(target_hash.to_yaml) }
                  puts "\nfile '#{target_file}' saved!"
                  exit
                end
                target_hash[@target_locale].dig(elements)[last] = val.to_s
              when '-'
                puts "removed obsolete key '#{key}'"
                target_hash[@target_locale].dig(elements).delete last
            end
          end
          diff = HashDiff.diff(target_hash[@target_locale],master_hash[@source_locale])
          diff = diff.select{ |e| !e[0].eql?('~') }
        end

        File.open(target_file,'w+') {|f| f.write(target_hash.to_yaml) }
        puts "file '#{target_file}' saved!"
      end
    end

  end
end