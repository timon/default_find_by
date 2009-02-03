module DefaultFindBy
  def default_find_by(field, options = {})
    class_inheritable_accessor :param_field
    self.param_field = field
    class_eval do
      class << self
        def find_with_default_accessor(*args)
          what = args.shift
          if what.is_a?(String)
            self.send("find_by_#{self.param_field}", what, *args)
          else
            find_without_default_accessor(what, *args)
          end
        end

        alias_method_chain :find, :default_accessor
      end

      def to_param
        self.send(self.class.param_field)
      end
    end
  end
end

