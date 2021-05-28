module I18nExtensions
  class HybridBackend < I18n::Backend::KeyValue
    module Implementation
      def initialize(addresses, subtrees: false)
        @store = ::Redis::Store::Factory.create(*addresses)
        super(@store, subtrees)
      end

      def initialized?
        @initialized && super
      end

      def available_locales
        init_translations unless initialized?
        super
      end

      def init_translations
        raise 'Already initialized' if @initialized

        populate_translations
        @initialized = true
      end

      def reload!
        @initialized = false
        super
      end

      def eager_load!
        init_translations unless initialized?
        super
      end

      def lookup(locale, key, scope = [], options = EMPTY_HASH)
        init_translations unless initialized?
        super
      end

      private

      def populate_translations
        Language.visible.each do |language|
          store_translations(language.locale, YAML.safe_load(language.translation)) if language.translation
        end
      rescue ActiveRecord::ActiveRecordError
        # Suppress activerecord errors
      end
    end

    include Implementation
  end
end
