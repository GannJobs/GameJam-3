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
    --love.graphics.line(love.graphics.getWidth()/2 - 80, 0, love.graphics.getWidth()/2 - 80, love.graphics.getHeight())
    --love.graphics.line(love.graphics.getWidth()/2 + 80, 0, love.graphics.getWidth()/2 + 80, love.graphics.getHeight())
    love.graphics.draw(self.BG, 0, 0)
    if self.vidas <= 0 then
        love.graphics.setNewFont(20)
        love.graphics.print("--Suas vidas acabaram, Você Perdeu!--", love.graphics.getWidth()/2 - 180, love.graphics.getHeight()/2 - 50)
    else
        if enemy.inimigos[20].Ivivo then
            love.graphics.print("Vidas Restantes: " .. self.vidas, 50, 50)
            love.graphics.print("Dinheiro: " .. hero.dinheiro, 50, 70)
        else
            love.graphics.setNewFont(20)
            love.graphics.print(" Você Sobreviveu ao ataque, Parabéns!", love.graphics.getWidth()/2 - 190, love.graphics.getHeight()/2 - 60)
        end
    end
end