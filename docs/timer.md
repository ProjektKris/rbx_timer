# timer

## Attributes

> ### `number` t<br>
> The amount of time to wait or between intervals of the loop

> ### `timer.mode` mode<br>
> The execution mode

> ### `RBXScriptSignal` timer<br>
> The timer signals that are used; E.g. `RunService.Heartbeat` 

> ### `function` clock<br>
> The method that returns time; E.g. `time`, `tick`, `os.time`

> ### `function` callback<br>
> Fired at the when the clock passes `next_execution` (clock >= next_execution) <br>
> default: `function() end`

> ### `timer.status` status<br>
> The status of the timer, i.e. `timer.dead`, `timer.alive`, `timer.paused`

> ### `number` next_execution

> ### `RBXScriptConnection` connection

## Events

Events are an attribute of the class, they are stored in the table `events`

> ### start

> ### pause

> ### disconnect

> ### callback_fired

## Constructor

> ### `timer` .new(`number` t, `timer.mode` mode, `RBXScriptSignal` timer, `function` clock, `function` callback)

## Methods

> ### `void` :start()<br>
> Starts the timer

> ### `void` :pause()<br>
> Pauses the timer

> ### `RBXScriptConnection` :on(`string` event_name, `function` listener)<br>
> Alternate method of connecting events