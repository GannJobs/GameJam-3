Campos = Classe:extend()

function Campos:new()

    self.width = 50
    self.height = 50
    self.xE = love.graphics.getWidth() / 2 - self.width / 2 - 160
    self.xD = love.graphics.getWidth() / 2 + self.width / 2 + 110
    self.y = self.height + 150

    --slots de torre

    self.slots = {}

    local y = 0
    local y2 = 0

    for i = 1, 6 do
        if i < 4 then  -- esquerda
            self.slots[i] = {
                img = love.graphics.newImage("Recursos/Imagens/BaseTorre.png"),
                Sx = self.xE,
                Sy = self.y + y,
                Swidth = self.width,
                Sheight = self.height
            }
        y = y + 200
        else           -- direita
            self.slots[i] = {
                img = love.graphics.newImage("Recursos/Imagens/BaseTorre.png"),
                Sx = self.xD,
                Sy = self.y + y2,
                Swidth = self.width,
                Sheight = self.height
            }
        y2 = y2 + 200
        end
    end

    --opcoes de escolha

    self.escolha = 0

    self.selecao = false
    self.raioS = 100

    self.opcoes = {}

    local yo = 0
    local yo2 = 0

    for i = 1, 6 do
        if i < 4 then -- lado esquerdo
        self.opcoes[i] = {
            img = love.graphics.newImage("Recursos/Imagens/OpcaoTorreLaser.png"),
            Tx = self.xE,
            Ty = self.y - self.raioS + yo,
            Twidth = 50,
            Theight = 50,
            Traio = 0,
            criada = false,
            Vrange = Vetor(0,0)
        }
        yo = yo + 200
        else           -- lado direito
            self.opcoes[i] = {
                img = love.graphics.newImage("Recursos/Imagens/OpcaoTorreLaser.png"),
                Tx = self.xD,
                Ty = self.y - self.raioS + yo2,
                Twidth = 50,
                Theight = 50,
                Traio = 0,
                criada = false,
                Vrange = Vetor(0,0)
            }
        yo2 = yo2 + 200
        end
    end

    

    cont = 0
end

function Campos:update(dt)

    -- criacao de torre

    for i = 1, 6 do

        if MouseSelection(self.slots[i].Swidth, self.slots[i].Sheight, self.slots[i].Sx, self.slots[i].Sy)then
            print("encima da casa ".. i)
            if love.mouse.isDown(1, 2, 3) then
                self.selecao = true
                self.escolha = i
                print("abrir selecao da casa"..self.escolha)
            end
        else
            if self.selecao and not(Range2(1, self.raioS, love.mouse.getX(), love.mouse.getY(), self.slots[self.escolha].Sx, self.slots[self.escolha].Sy)) then
                if love.mouse.isDown(1, 2, 3) then
                    print("fechar selecao da casa"..self.escolha)
                    self.selecao = false
                end
            end
        end
    end

        if self.selecao and not(self.opcoes[self.escolha].criada) then
            if MouseSelection(self.opcoes[self.escolha].Twidth, self.opcoes[self.escolha].Theight, self.opcoes[self.escolha].Tx, self.opcoes[self.escolha].Ty) and not(self.opcoes[self.escolha].criada) then
                print("encima da escolha do slot "..self.escolha)
                if love.mouse.isDown(1, 2, 3) and hero.dinheiro >= 80 then
                    hero.dinheiro = hero.dinheiro - 80
                    print("torre criada")
                    self.opcoes[self.escolha] = {
                        img = love.graphics.newImage("Recursos/Imagens/TorreLaser.png"),
                        Tx = self.slots[self.escolha].Sx,
                        Ty = self.slots[self.escolha].Sy,
                        Twidth = 50,
                        Theight = 50,
                        Traio = 200,
                        criada = true,
                        Vrange = Vetor(self.slots[self.escolha].Sx + self.slots[self.escolha].Swidth/2, self.slots[self.escolha].Sy + self.slots[self.escolha].Sheight/2)
                    }
                    self.selecao = false
                    print("selecao fechada da casa "..self.escolha)
                    self.escolha = 0
                end
            end
        else
            self.selecao = false
            self.escolha = 0
        end

    -- ataque de torre

    cont = cont + dt
    
    for i = 1, 6 do
        for a = 1, 20 do
            if self.opcoes[i].criada  then
                if Range(self.opcoes[i].Traio, enemy.inimigos[a].Iraio, self.opcoes[i].Vrange, enemy.inimigos[a].IV) then
                    if cont > 1 and enemy.inimigos[a].Ivida >= 0 then -- damage
                        enemy.inimigos[a].Ivida = enemy.inimigos[a].Ivida - 20
                        print(enemy.inimigos[a].Ivida)
                        cont = 0
                    end
                end
            end
        end
    end

end

function Campos:draw()

    -- desenha slots de torre

    for i = 1, 6 do

        --love.graphics.rectangle("line", self.slots[i].Sx, self.slots[i].Sy, self.slots[i].Swidth, self.slots[i].Sheight)
        love.graphics.draw(self.slots[i].img, self.slots[i].Sx - self.slots[i].Swidth + 7, self.slots[i].Sy - self.slots[i].Sheight + 8)
        -- desenha a seleçao dos tipos de torre
        if not(self.escolha == 0) then
            if self.selecao and not(self.opcoes[self.escolha].criada) then
            -- raio de escolha
            love.graphics.circle("line", self.slots[self.escolha].Sx + self.slots[self.escolha].Swidth / 2, self.slots[self.escolha].Sy + self.slots[self.escolha].Sheight / 2, self.raioS)
            -- opçoes
            -- love.graphics.rectangle("fill", self.opcoes[self.escolha].Tx, self.opcoes[self.escolha].Ty, self.opcoes[self.escolha].Twidth, self.opcoes[self.escolha].Theight)
            love.graphics.draw(self.opcoes[self.escolha].img, self.opcoes[self.escolha].Tx - self.opcoes[self.escolha].Twidth + 11, self.opcoes[self.escolha].Ty - self.opcoes[self.escolha].Theight + 12)
            love.graphics.print("R$ 80", self.opcoes[self.escolha].Tx+5, self.opcoes[self.escolha].Ty - 30)
            end
        end
    end

    -- desenha a torre criada
    for i = 1, 6 do
        if self.opcoes[i].criada  then
        -- torre
            --love.graphics.rectangle("fill", self.opcoes[i].Tx, self.opcoes[i].Ty, self.opcoes[i].Twidth, self.opcoes[i].Theight)
            --love.graphics.rectangle("fill", self.opcoes[i].Tx, self.opcoes[i].Ty - self.opcoes[i].Theight, self.opcoes[i].Twidth, self.opcoes[i].Theight)
            love.graphics.draw(self.opcoes[i].img, self.opcoes[i].Tx - self.opcoes[i].Twidth + 11, self.opcoes[i].Ty - self.opcoes[i].Theight + 12)
            -- range
            -- love.graphics.circle("line", self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty + self.opcoes[i].Theight / 2, self.opcoes[i].Traio)
            love.graphics.circle("line", self.opcoes[i].Vrange.x , self.opcoes[i].Vrange.y, self.opcoes[i].Traio)

            -- olho da torre
            --love.graphics.circle("fill", self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty - self.opcoes[i].Theight / 2, 5)

            -- ataque da torre laser
            for a = 1, 20 do
                if Range(self.opcoes[i].Traio, enemy.inimigos[a].Iraio, self.opcoes[i].Vrange, enemy.inimigos[a].IV) then
                    love.graphics.line(self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty - self.opcoes[i].Theight / 2, enemy.inimigos[a].IV.x, enemy.inimigos[a].IV.y)
                end
            end
        end
    end

    -- evolui a torre
end
