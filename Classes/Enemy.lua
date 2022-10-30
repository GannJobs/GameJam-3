Enemy = Classe:extend()

function Enemy:new()
    self.raio = 25
    self.x = love.graphics.getWidth() / 2
    -- self.x = love.math.random(love.graphics.getWidth()/2 - 80, love.graphics.getWidth()/2 + 80)
    self.y = 0 - self.raio
    self.speed = 70
    self.V = Vetor(self.x, self.y)
    self.vida = 50
    self.vivo = true

    self.wave = 3
end

function Enemy:update(dt)
    self:Move(dt)
    self:Morte()
end

function Enemy:Move(dt)
    -- preparar parte para movimentar em direção ao hero ou as unidades das barracas
    self.y = self.y + self.speed * dt
    self.V.y = self.y
end

function Enemy:Morte()
    -- drop de dinheiro
    if self.vida < 0 and self.vivo then
        self.vivo = false
        hero.dinheiro = hero.dinheiro + 70
        self.speed = 0
        self.x = 0
        self.y = 0
        self.raio = 0
    end
    -- causa dano ao jogador
    if self.y + self.raio > love.graphics.getHeight() then
        map.vidas = map.vidas - 1
        self.vivo = false
        self.speed = 0
        self.x = 0
        self.y = 0
        self.raio = 0
    end
end

function Enemy:draw()
    if(self.vida > 0) then
        --love.graphics.setColor(0, 255, 0)
        love.graphics.circle("line", self.x, self.y, self.raio)
        --love.graphics.setColor(255,0,0)
        love.graphics.rectangle("fill", self.x - self.raio, self.y - 40, self.vida, 10)
    end
end
