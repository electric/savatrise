module Savalicious

  private

    def define_tab
      set_active_tab request.path
    end

    def set_active_tab tab_name
      @active_tab = (tab_name.is_a?(Array))? tab_name : tab_name.to_s
    end

    def set_parent_tab tab_name
      @parent_tab = (tab_name.is_a?(Array))? tab_name : tab_name.to_s
    end

end