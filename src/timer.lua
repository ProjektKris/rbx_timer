--[[
    Author: @ProjektKris
]]

local module = {
    modes = {
        timer = 1,
        dowhile = 2,
        whiledo = 3
    },
    status = {
        dead = 1,
        alive = 2,
        paused = 3
    },
    new = function(t, mode, timer, clock, callback) -- constructor
        return {
            -- public variables
            t = t,
            mode = mode,
            timer = timer,
            clock = clock,
            callback = callback or function ()end,
    
            status = 1,
            next_execution = clock()+t,
            connection = nil,
    
            events = {
                start = Instance.new('BindableEvent'),
                pause = Instance.new('BindableEvent'),
                disconnect = Instance.new('BindableEvent'),
                callback_fired = Instance.new('BindableEvent')
            },
    
            -- methods
            start = function(self)
                self.events.start:Fire()
    
                if mode == 1 then--'timer' then
                    local st = self.clock()
                    self.status = 2
                    self.connection = self.timer:Connect(function()
                        local cr
                        local dt = self.clock() - st
                        st = self.clock()
                        if self.status == 3 then
                            self.next_execution = self.next_execution + dt
                        else
                            if self.clock() >= self.next_execution then
                                self:disconnect()
        
                                cr = callback()
                                self.events.callback_fired:Fire(cr)
                            end
                        end
                    end)
                elseif mode == 2 then--'dowhile' then
                    local cr = callback()
                    self.events.callback_fired:Fire(cr)
    
                    local st = self.clock()
                    self.status = 2
                    self.connection = self.timer:Connect(function()
                        local dt = self.clock() - st
                        st = self.clock()
                        if self.status == 3 then
                            self.next_execution = self.next_execution + dt
                        else
                            if self.clock() >= self.next_execution then
                                self.next_execution = self.clock() + self.t
                                cr = callback()
                                self.events.callback_fired:Fire(cr)
                            end
                        end
                    end)
                elseif mode == 3 then--'whiledo' then
                    local cr
                    local st = self.clock()
                    self.status = 2
                    self.connection = self.timer:Connect(function()
                        local dt = self.clock() - st
                        st = self.clock()
                        if self.status == 3 then
                            self.next_execution = self.next_execution + dt
                        else
                            if self.clock() >= self.next_execution then
                                self.next_execution = self.clock() + self.t
                                cr = callback()
                                self.events.callback_fired:Fire(cr)
                            end
                        end
                    end)
                end
            end,
    
            pause = function(self)
                self.status = 3
                self.events.pause:Fire()
            end,
    
            on = function(self, event_name, listener)
                if self[event_name] then
                    return self[event_name].Event:Connect(listener)
                end
            end
        }
    end
}

return module