module Draftable::Models
  class << self
    def define!
      self.draftable_map.each do |base_name, draft_name|
        Object.const_set(draft_name.to_sym, Class.new(base_name.constantize)).class_eval do
          establish_connection("draft_" + Rails.env.to_s)

          reflections.each do |key , value|
            if value.options.has_key?(:through)
              self.send value.macro, key, class_name: value.active_record, through: value.options[:through], source: value.options[:through]
            else
              self.send value.macro, key, class_name: value.active_record
            end
          end
        end
      end
    end

    def draftable_map
      Hash[self.base_list.zip(self.draft_list)]
    end

    def draft_list
      self.list.map { |m| "Draft#{m}" }
    end

    def base_list
      self.list
    end

    def list
      self.all_models.sort.reject { |m| self.blacklist.include? m.to_s }.select { |m| m.constantize.respond_to?(:draftable?) }
    end

    def blacklist
      b = []
      self.all_models.each do |m|
        b << m if m.to_s.match 'Draft'
      end
      b
    end

    def all_models
      Dir['app/models/*.rb'].map { |f| File.basename(f, '.*').camelize.constantize.name }
    end
  end
end
