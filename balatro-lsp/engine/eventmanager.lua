--- @meta

--- @class balatro.EventManager: balatro.Object
--- Queue list
--- @field queues balatro.EventManager.Queues
--- Current event time. This may deviate from `G.TIMERS`,
--- Updated by `update()`.
--- @field queue_timer number
--- Update frequency. Defaults to `1/60`.
--- @field queue_dt number
--- Last time when the queue is processed.
--- Updated by `update()`.
--- @field queue_last_processed number
local IEventManager = {}

--- Adds an event to EventManager
--- @param event balatro.Event Event to add
--- @param queue? balatro.EventManager.QueueType Where to add the event. Defaults to `base``
--- @param front? boolean Adds the event in front of the queue
function IEventManager:add_event(event, queue, front) end

--- @param queue? balatro.EventManager.QueueType Queue type to delete.
--- @param exception? balatro.EventManager.QueueType If specified, deletes all but this queue type.
function IEventManager:clear_queue(queue, exception) end

--- @param dt number
--- @param forced? boolean
function IEventManager:update(dt, forced) end

--- @type balatro.EventManager | fun(): balatro.EventManager
EventManager = function() end

--- @class balatro.EventManager.Queues: { [string]: balatro.Event[] }
--- @field unlock balatro.Event[]
--- @field base balatro.Event[]
--- @field tutorial balatro.Event[]
--- @field achievement balatro.Event[]
--- @field other balatro.Event[]

--- @alias balatro.EventManager.QueueType "unlock" | "base" | "tutorial" | "achievement" | "other" | string
