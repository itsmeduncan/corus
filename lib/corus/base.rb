module Corus::Base
  CLASS_VARIABLE_NAME = :@@_corus_fields

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def corus *fields
      class_variable_set(Corus::Base::CLASS_VARIABLE_NAME, fields)

      validate :_corus_nonnullablity
    end
  end

  private

    def _corus_nonnullablity
      _corus_fields.each do |attribute|
        original_value = self.send("#{attribute}_was".to_sym)
        new_value      = self.send(attribute)

        if !original_value.nil? && new_value.nil?
          errors.add(attribute, "can't be changed from '#{original_value}' to nil")
        end
      end
    end

    def _corus_fields
      @_corus_fields ||= self.class.send(:class_variable_get, Corus::Base::CLASS_VARIABLE_NAME)
    end

end

ActiveRecord::Base.send :include, Corus::Base