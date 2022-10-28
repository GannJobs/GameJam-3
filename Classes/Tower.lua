Tower = Classe:extend()

function Tower:new()
    self.width = 50
    self.height = 50
    self.x = love.graphics.getWidth() / 2 - self.width / 2 - 160
    self.y = self.height
    self.raio = 200
    self.V = Vetor(self.x + self.width / 2, self.y + 25)

    cont = 0

    -- self.projetil = {
    --     posicao = Vetor(self.x, self.y),
    --     velocidade = 300,
    --     desenha = false,
    -- }
end

-- function Tower:disparo(dt)
--     self.projetil.desenha = true
--     self.direcao = enemy.V - self.projetil.posicao
--     self.angulo = -self.direcao:heading()
--     self.projetil.posicao = self.projetil.posicao + self.direcao:limit(self.projetil.velocidade) * dt
-- end

function Tower:update(dt)
    -- cont = cont + dt
    -- if Range(self.raio, enemy.raio, self.V, enemy.V) then
    --     if cont > 1 and enemy.vida > 0 then -- damage
    --         enemy.vida = enemy.vida - 20
    --     end
    -- else
    --     self.projetil.desenha = false
    -- end
end

function Tower:draw()
    -- love.graphics.setColor(255, 0, 255)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    -- love.graphics.circle("line", self.x + self.width / 2, self.y + self.height / 2, self.raio)

    -- if Range(self.raio, enemy.raio, self.V, enemy.V) then
    --     love.graphics.line(self.V.x, self.V.y, enemy.V.x, enemy.V.y)
    -- end
    -- if self.projetil.desenha then
    --     love.graphics.rectangle("fill", self.projetil.posicao.x, self.projetil.posicao.y, 10, 10)
    -- end
end