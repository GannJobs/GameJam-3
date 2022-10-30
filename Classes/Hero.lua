Hero = Classe:extend()

function Hero:new()
    self.width = 25
    self.height = 25
    self.x = love.graphics.getWidth() / 2 - self.width / 2
    self.y = love.graphics.getHeight() / 2 - self.height / 2
    self.speed = 200

    self.dinheiro = 100
    --espada
    -- self.espada = {
    --     imagem = love.graphics.newImage("recursos/imagens/sword1.png"),
    --     x = self.x + 20,
    --     y = self.y + 10,
    --     ang = 150,
    --     corte = 400,
    --     raio = 61
    -- }
end

function Hero:update(dt)
    self:Move(dt)
end

function Hero:Move(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
        -- self.espada.y = self.espada.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
        --self.espada.y = self.espada.y + self.speed * dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
        --self.espada.x = self.espada.x - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
        --self.espada.x = self.espada.x + self.speed * dt
    end
    -- if love.keyboard.isDown("space") then --ataque giratorio
    --     self.espada.ang = self.espada.ang + self.espada.corte * dt 
    --     print(self.espada.XY)
    --     if RangeSword(self.espada.raio, enemy.raio, self.espada.x, self.espada.y, enemy.V) then
    --         if enemy.vida > 0 then -- corte lateral
    --             print("Corte lateral!!!!!")
    --             enemy.vida = enemy.vida - 0.2
    --         end
    --     end
    -- end
end

function Hero:draw()
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    --sword
    --love.graphics.draw(self.espada.imagem, self.espada.x, self.espada.y, self.espada.ang)
    --love.graphics.setColor(0,0,0)
    --sword raio
    --love.graphics.circle("line", self.espada.x, self.espada.y, self.espada.raio)
end
