Enemy = Classe:extend()

function Enemy:new()
    self.raio = 25
    self.x = love.graphics.getWidth() / 2
    self.y = 0 - self.raio
    self.speed = 50
    self.V = Vetor(self.x, self.y)
    self.vida = 50
end

function Enemy:update(dt)
    self:Move(dt)
end

function Enemy:Move(dt)
    -- preparar parte para movimentar em direção ao hero ou as unidades das barracas
    self.y = self.y + self.speed * dt
    self.V.y = self.y
end

function Enemy:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle("line", self.x, self.y, self.raio)
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", self.x - self.raio, self.y - 40, self.vida, 10)
end
