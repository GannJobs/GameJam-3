function love.load()
    Classe = require "Suporte/classic"
    Vetor = require "Suporte/vector"
    
    require "Classes.Hero"
    hero = Hero()

    require "Classes.Map"
    map = Map()

    require "Classes.Enemy"
    enemy = Enemy()

    require "Classes.Tower"
    tower = Tower()

    require "Classes.Campos"
    campos = Campos()


end

function love.update(dt)
    hero:update(dt)
    enemy:update(dt)
    map:update(dt)
    tower:update(dt)
    campos:update(dt)
end

function love.draw()
    map:draw()
    enemy:draw()
    tower:draw()
    campos:draw()
    hero:draw()
end

function Range(a, b, Va, Vb)
    local DistVetores = math.sqrt((Va.x-Vb.x)^2 + (Va.y-Vb.y)^2)
    if a + b >= DistVetores then
        return true
    else 
        return false
    end
end

function RangeSword(a, b, Vax, Vay, Vb)
    local DistVetores = math.sqrt((Vax-Vb.x)^2 + (Vay-Vb.y)^2)
    if a + b >= DistVetores then
        return true
    else 
        return false
    end
end

function Range2(a, b, Vax, Vay, Vbx, VbY)
    local DistVetores = math.sqrt((Vax-Vbx)^2 + (Vay-VbY)^2)
    if a + b >= DistVetores then
        return true
    else 
        return false
    end
end

function MouseSelection(a, b, x, y)
    local mx, my = love.mouse.getPosition()
    if mx >= x and mx <= x + a and my >= y and my <= y + b then
        return true
    else
        return false
    end
end