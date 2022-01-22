class LRUCache
    def initialize(limit)
        @cache = []
        @limit = limit
    end

    def count
        @cache.length
    end

    def add(el)
        if count < @limit
            @cache << el
            true
        elsif requeue_cache_item(el)
            true
        else
            @cache.shift
            @cache << el
        end
    end

    def show
        p @cache
    end

    private
    def requeue_cache_item(el)
        idx = @cache.index(el)
        return false unless idx
        
        @cache.delete(el)
        @cache << el
    end

end
