Enemy = Classe:extend()

function Enemy:new()
    self.img = love.graphics.newImage("Recursos/Imagens/InimigoMedio.png")
    self.raio = 25
    --self.x = love.graphics.getWidth() / 2
    --Ex = love.math.random(love.graphics.getWidth()/2 - 80, love.graphics.getWidth()/2 + 80)
    --print(Ex)
    --self.x = Ex
    self.y = 100 - self.raio
    self.speed = 70
    self.V = Vetor(self.x, self.y)
    self.vida = 50
    self.vivo = true

    --self.wave = 3

    self.inimigos = {}
    y = 0

    for i = 1, 20 do
        self.inimigos[i] = {
            Iimg = self.img,
            Iraio = self.raio,
            Ix = love.math.random(230, 370),
            Iy = self.y - y,
            Ispeed = 70,
            IV = Vetor(0, 0),
            Ivida = 50,
            Ivivo = true
        }
        y = y + 300
    end
end

function Enemy:update(dt)
    for i=1, 20 do
        self.inimigos[i].IV = Vetor(self.inimigos[i].Ix, self.inimigos[i].Iy)
        self.inimigos[i].Iy = self.inimigos[i].Iy + self.inimigos[i].Ispeed * dt
        self.inimigos[i].IV.y = self.inimigos[i].Iy
    end
    self:Morte()
end

-- function Enemy:Move(dt)
--     -- preparar parte para movimentar em direção ao hero ou as unidades das barracas
--     self.y = self.y + self.speed * dt
--     self.V.y = self.y
-- end

function Enemy:Morte()
    -- drop de dinheiro
    for i = 1, 20 do 
        if self.inimigos[i].Ivida <= 0 and self.inimigos[i].Ivivo then
            self.inimigos[i].Ivivo = false
            hero.dinheiro = hero.dinheiro + 70
            self.inimigos[i].Ispeed = 0
            self.inimigos[i].Ix = 0
            self.inimigos[i].Iy = 0
            self.inimigos[i].Iraio = 0
        end
        -- causa dano ao jogador
        if self.inimigos[i].Iy + self.inimigos[i].Iraio > love.graphics.getHeight() then
            map.vidas = map.vidas - 1
            self.inimigos[i].Ivivo = false
            self.inimigos[i].Ispeed = 0
            self.inimigos[i].Ix = 0
            self.inimigos[i].Iy = 0
            self.inimigos[i].Iraio = 0
        end
    end 
end

function Enemy:draw()
    for i=1, 20 do
        if(self.inimigos[i].Ivida > 0 and self.inimigos[i].Ivivo) then
            --love.graphics.setColor(0, 255, 0)
            --love.graphics.circle("line", self.x, self.y, self.raio)
            love.graphics.draw(self.inimigos[i].Iimg, self.inimigos[i].Ix - self.inimigos[i].Iraio, self.inimigos[i].Iy - self.inimigos[i].Iraio)
            --love.graphics.setColor(255,0,0)
            love.graphics.rectangle("fill", self.inimigos[i].Ix - self.inimigos[i].Iraio, self.inimigos[i].Iy - 40, self.inimigos[i].Ivida, 10)
        end
    end
end
