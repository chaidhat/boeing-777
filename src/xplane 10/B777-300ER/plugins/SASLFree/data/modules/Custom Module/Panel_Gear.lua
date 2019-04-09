-- Panel_Gear.lua --
-- Chai112 Boeing 777-300ER     1-06-018

-- Script Version   1.0.0
-- Aircraft Version 0.40.0



local b = 0

function update ()

	if not (get(globalPropertyf("donut/panel/gear")) == 0) then
        if not (get(globalPropertyf("donut/panel/gear")) == 1) then
            if (get(globalPropertyf("donut/panel/gear")) > 0.5) then
                if (get(globalPropertyf("donut/panel/gear")) + 0.1 > 1) then
                    set(globalPropertyf("donut/panel/gear"), 1);
                    b = 1;
                 else
                    set(globalPropertyf("donut/panel/gear"), get(globalPropertyf("donut/panel/gear")) + 0.1);
                    b = 1;
                end
             else
                if (get(globalPropertyf("donut/panel/gear")) - 0.1 < 0) then
                    set(globalPropertyf("donut/panel/gear"), 0);
                    b = 0;
                 else
                    set(globalPropertyf("donut/panel/gear"), get(globalPropertyf("donut/panel/gear")) - 0.1);
                    b = 0;
                end
            end
            
         else
            --Check if the user pressed 'g'
            if (get(globalPropertyi("sim/cockpit/switches/gear_handle_status")) == 0) then
                if (b == 0) then
                    set(globalPropertyf("donut/panel/gear"), 0.5);
                 else
                    set(globalPropertyi("sim/cockpit/switches/gear_handle_status"), 1);
                end
             else
                set(globalPropertyi("sim/cockpit/switches/gear_handle_status"), 1);
                b = 0;
            end
        end
     else
        --Check if the user pressed 'g'
        if (get(globalPropertyi("sim/cockpit/switches/gear_handle_status")) == 1) then
            if (b == 1) then
                set(globalPropertyf("donut/panel/gear"), 0.51);
             else
                set(globalPropertyi("sim/cockpit/switches/gear_handle_status"), 0);
            end
         else
            set(globalPropertyi("sim/cockpit/switches/gear_handle_status"), 0);
            b = 1;
        end
    end
    

end -- end update
