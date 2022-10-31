Map = Classe:extend()

function Map:new()
    self.BG = love.graphics.newImage("Recursos/Imagens/Fundo.png")
    self.vidas = 20
end

function Map:update(dt)
    if enemy.y + enemy.raio < 0 then
        self.vidas = self.vidas - 1
    end
end

function Map:draw()
    love.graphics.print("Vidas Restantes: " .. self.vidas, 50, 50)
    love.graphics.print("Dinheiro: " .. hero.dinheiro, 50, 70)
    love.graphics.print("Waves: " .. enemy.wave, 50, 90)
    love.graphics.line(love.graphics.getWidth()/2 - 80, 0, love.graphics.getWidth()/2 - 80, love.graphics.getHeight())
    love.graphics.line(love.graphics.getWidth()/2 + 80, 0, love.graphics.getWidth()/2 + 80, love.graphics.getHeight())
    love.graphics.draw(self.BG, 0, 0)
end