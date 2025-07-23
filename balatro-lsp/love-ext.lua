--- @meta

--- @param deltaSeconds number
function love.update(deltaSeconds) end

function love.draw() end

--- @param args string[]
--- @param unfilteredArg string[]
function love.load(args, unfilteredArg) end

function love.lowmemory() end

--- @param code? number | "restart"
function love.quit(code) end

--- @param thread thread
function love.threaderror(thread) end

--- @param path string
function love.directorydropped(path) end

--- @param index number
--- @param orientation love.DisplayOrientation
function love.displayrotated(index, orientation) end

--- @param file love.DroppedFile
function love.filedropped(file) end

--- @param focus boolean
function love.focus(focus) end

--- @param focus boolean
function love.mousefocus(focus) end

--- @param w number
--- @param h number
function love.resize(w, h) end

--- @param visible boolean
function love.visible(visible) end

--- @param key love.KeyConstant
--- @param scancode love.Scancode
--- @param isrepeat boolean
function love.keypressed(key, scancode, isrepeat) end

--- @param key love.KeyConstant
--- @param scancode love.Scancode
function love.keyreleased(key, scancode) end

--- @param text string
--- @param start number
--- @param length number
function love.textedited(text, start, length) end

--- @param text string
function love.textinput(text) end

--- @param x number
--- @param y number
--- @param dx number
--- @param dy number
--- @param touch boolean
function love.mousemoved(x, y, dx, dy, touch) end

--- @param x number
--- @param y number
--- @param button number
--- @param touch boolean
function love.mousepressed(x, y, button, touch) end

--- @param x number
--- @param y number
--- @param button number
--- @param touch boolean
function love.mousereleased(x, y, button, touch) end

--- @param x number
--- @param y number
function love.wheelmoved(x, y) end

--- @param joystick love.Joystick
--- @param axis love.GamepadAxis
--- @param value number
function love.gamepadaxis(joystick, axis, value) end

--- @param joystick love.Joystick
--- @param button love.GamepadButton
function love.gamepadpressed(joystick, button) end

--- @param joystick love.Joystick
--- @param button love.GamepadButton
function love.gamepadreleased(joystick, button) end

--- @param joystick love.Joystick
function love.joystickadded(joystick) end

--- @param joystick love.Joystick
--- @param axis love.GamepadAxis
--- @param value number
function love.joystickaxis(joystick, axis, value) end

--- @param joystick love.Joystick
--- @param hat number
--- @param direction love.JoystickHat
function love.joystickhat(joystick, hat, direction) end

--- @param joystick love.Joystick
--- @param button number
function love.joystickpressed(joystick, button) end

--- @param joystick love.Joystick
--- @param button number
function love.joystickreleased(joystick, button) end

--- @param joystick love.Joystick
function love.joystickremoved(joystick) end

--- @param id lightuserdata
--- @param x number
--- @param y number
--- @param dx number
--- @param dy number
--- @param pressure number
function love.touchmoved(id, x, y, dx, dy, pressure) end

--- @param id lightuserdata
--- @param x number
--- @param y number
--- @param dx number
--- @param dy number
--- @param pressure number
function love.touchpressed(id, x, y, dx, dy, pressure) end

--- @param id lightuserdata
--- @param x number
--- @param y number
--- @param dx number
--- @param dy number
--- @param pressure number
function love.touchreleased(id, x, y, dx, dy, pressure) end

--- @param error string
function love.errorhandler(error) end