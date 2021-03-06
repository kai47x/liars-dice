Buttons = {}

local snapSound = love.audio.newSource( 'sound/snap_dice.mp3','static' )

function newButton(xp,yp,w,h,name,func)
  if xp == nil then
    xp = 0
    yp = 0
    w = 100
    h = 100
  end

  if name == nil then
    name = 'Button'
  end

  if func == nil then
    func = function()
      print('no functionality for this button')
    end
  end

  local button = {
    x = xp,
    y = yp,
    width = w,
    height = h,
    name = name,
    hide = false,

    hover = function(self)
      local mx,my = love.mouse.getX(),love.mouse.getY()
      return mx > self.x and
       my > self.y and
        mx < self.x + self.width and
         my < self.y + self.height
    end,

    draw = function(self)
      if self.hide then return end
      local fill = 'line'
      if self:hover() then fill = 'fill' end
      love.graphics.setColor(100, 100, 255)
      love.graphics.rectangle(fill, self.x, self.y, self.width, self.height)
      love.graphics.setColor(255,255,255)
      love.graphics.print(self.name,self.x+10,self.y+10)
    end,

    onClick = func
  }

  Buttons[#Buttons + 1] = button
  return button
end

function love.mousepressed(x, y, button, isTouch)
  if button == 1 then
    for i=1,#Buttons do
      local b = Buttons[i]
      if b:hover() and not b.hide then
        b.onClick()
        snapSound:stop()
        snapSound:play()
      end
    end
  end
end
