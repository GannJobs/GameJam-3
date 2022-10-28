Jogo = Classe:extend()

function Jogo:new()

end

function Jogo:update(dt)
    if Range(tower.raio, enemy.raio, tower.V, enemy.V) then
        print("Mirando")
    end
end

function Jogo:draw()

end