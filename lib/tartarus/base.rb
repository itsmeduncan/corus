module Tartarus::Base
  CLASS_VARIABLE_NAME = :@@_tartarus_fields

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def tartarus *fields
      class_variable_set(Tartarus::Base::CLASS_VARIABLE_NAME, fields)

      validate :_tartarus_nonnullablity
    end
  end

  private
    def _tartarus_nonnullablity
      _tartarus_fields.each do |attribute|
        original_value = self.send("#{attribute}_was".to_sym)
        new_value      = self.send(attribute)

        if !original_value.nil? && new_value.nil?
          errors.add(attribute, "can't be changed from '#{original_value}' to nil")
        end
      end
    end

    def _tartarus_fields
      @_tartarus_fields ||= self.class.send(:class_variable_get, Tartarus::Base::CLASS_VARIABLE_NAME)
    end

end

ActiveRecord::Base.send :include, Tartarus::Base