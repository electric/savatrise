module Savalicious

  private

    def define_tab
      set_active_tab "#{controller_name}_#{action_name}"
    end

    def set_active_tab tab_name
      @active_tab = tab_name.to_sym
    end
  
end