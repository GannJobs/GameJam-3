Campos = Classe:extend()

function Campos:new()

    self.width = 50
    self.height = 50
    self.xE = love.graphics.getWidth() / 2 - self.width / 2 - 160
    self.xD = love.graphics.getWidth() / 2 + self.width / 2 + 110
    self.y = self.height + 150
    self.img1 = love.graphics.newImage("Recursos/Imagens/TorreLaser.png")
    self.img2 = love.graphics.newImage("Recursos/Imagens/TorreLevel2.png")
    self.imgO = love.graphics.newImage("Recursos/Imagens/OpcaoTorreLaser.png")
    self.img2O =  love.graphics.newImage("Recursos/Imagens/TorreLevel2Op.png")

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

    for i = 1, 6 do -- torres base
        if i < 4 then -- lado esquerdo
        self.opcoes[i] = {
            Timg = self.img1,
            Tx = self.xE,
            Ty = self.y - self.raioS + yo,
            Twidth = 50,
            Theight = 50,
            Traio = 0,
            criada = false,
            Vrange = Vetor(0,0),
            level = 1
        }
        yo = yo + 200
        else          -- lado direito
            self.opcoes[i] = {
                Timg = self.img1,
                Tx = self.xD,
                Ty = self.y - self.raioS + yo2,
                Twidth = 50,
                Theight = 50,
                Traio = 0,
                criada = false,
                Vrange = Vetor(0,0),
                level = 1
            }
        yo2 = yo2 + 200
        end
    end

    self.opcoes2 = {}

    yo = 0
    yo2 = 0

    for i = 1, 6 do -- torre lvl 2
        if i < 4 then -- lado esquerdo
        self.opcoes2[i] = {
            T2img = self.img2O,
            T2x = self.xE,
            T2y = self.y - self.raioS + yo,
            T2width = 50,
            T2height = 50,
        }
        yo = yo + 200
        else          -- lado direito
            self.opcoes2[i] = {
                T2img = self.img2O,
                T2x = self.xD,
                T2y = self.y - self.raioS + yo2,
                T2width = 50,
                T2height = 50,
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
            if love.mouse.isDown(1, 2, 3) then
                self.selecao = true
                self.escolha = i
                if self.opcoes[self.escolha].criada and self.opcoes[self.escolha].level == 2 then
                    self.selecao = false
                    self.escolha = 0
                end
            end
        else
            if self.selecao and not(Range2(1, self.raioS, love.mouse.getX(), love.mouse.getY(), self.slots[self.escolha].Sx, self.slots[self.escolha].Sy)) then
                if love.mouse.isDown(1, 2, 3) then
                    self.selecao = false
                end
            end
        end
    end

        if self.selecao and not(self.opcoes[self.escolha].criada) then
            if MouseSelection(self.opcoes[self.escolha].Twidth, self.opcoes[self.escolha].Theight, self.opcoes[self.escolha].Tx, self.opcoes[self.escolha].Ty) and not(self.opcoes[self.escolha].criada) then
                if love.mouse.isDown(1, 2, 3) and map.dinheiro >= 80 then
                    map.dinheiro = map.dinheiro - 80
                    self.opcoes[self.escolha] = {
                        Timg = self.img1,
                        Tx = self.slots[self.escolha].Sx,
                        Ty = self.slots[self.escolha].Sy,
                        Twidth = 50,
                        Theight = 50,
                        Traio = 200,
                        criada = true,
                        Vrange = Vetor(self.slots[self.escolha].Sx + self.slots[self.escolha].Swidth/2, self.slots[self.escolha].Sy + self.slots[self.escolha].Sheight/2),
                        level = 1
                    }
                    self.selecao = false
                    self.escolha = 0
                end
            end
        end

        if self.selecao and self.opcoes[self.escolha].criada and self.opcoes[self.escolha].level == 1 then
            if MouseSelection(self.opcoes2[self.escolha].T2width, self.opcoes2[self.escolha].T2height, self.opcoes2[self.escolha].T2x, self.opcoes2[self.escolha].T2y) then
                if love.mouse.isDown(1, 2, 3) and map.dinheiro >= 120 then
                    map.dinheiro = map.dinheiro - 120
                    self.opcoes[self.escolha].Timg = self.img2
                    self.opcoes[self.escolha].Traio = 220
                    self.opcoes[self.escolha].level = 2
                    self.selecao = false
                    self.escolha = 0
                end
            end
        end

    -- ataque de torre

    cont = cont + dt
    
    for i = 1, 6 do
        for a = 1, 20 do
            if self.opcoes[i].criada  then
                if Range(self.opcoes[i].Traio, enemy.inimigos[a].Iraio, self.opcoes[i].Vrange, enemy.inimigos[a].IV) then
                    if cont > 1 and enemy.inimigos[a].Ivida >= 0 then -- damage
                        if self.opcoes[i].level == 1 then
                            enemy.inimigos[a].Ivida = enemy.inimigos[a].Ivida - 12
                            cont = 0
                        else
                            enemy.inimigos[a].Ivida = enemy.inimigos[a].Ivida - 20
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

        love.graphics.draw(self.slots[i].img, self.slots[i].Sx - self.slots[i].Swidth + 7, self.slots[i].Sy - self.slots[i].Sheight + 8)
        -- desenha a seleçao dos tipos de torre
        if not(self.escolha == 0) then
            if self.selecao and not(self.opcoes[self.escolha].criada) then
            -- raio de escolha
            love.graphics.circle("line", self.slots[self.escolha].Sx + self.slots[self.escolha].Swidth / 2, self.slots[self.escolha].Sy + self.slots[self.escolha].Sheight / 2, self.raioS)
            -- opçoes
            love.graphics.draw(self.imgO, self.opcoes[self.escolha].Tx - self.opcoes[self.escolha].Twidth + 11, self.opcoes[self.escolha].Ty - self.opcoes[self.escolha].Theight + 12)
            love.graphics.print("R$ 80", self.opcoes[self.escolha].Tx+5, self.opcoes[self.escolha].Ty - 30)
            end

            --upar a torre
            if self.opcoes[self.escolha].criada then 
            -- raio de escolha
            love.graphics.circle("line", self.opcoes[self.escolha].Tx + 25, self.opcoes[self.escolha].Ty + 25, self.raioS)
            -- -- opçoes
            love.graphics.draw(self.img2O, self.opcoes2[self.escolha].T2x - 39, self.opcoes2[self.escolha].T2y - 36)
            end
        end
    end

    -- desenha a torre criada
    for i = 1, 6 do
        if self.opcoes[i].criada  then
        -- torre
            love.graphics.draw(self.opcoes[i].Timg, self.opcoes[i].Tx - self.opcoes[i].Twidth + 11, self.opcoes[i].Ty - self.opcoes[i].Theight + 12)
            love.graphics.circle("line", self.opcoes[i].Vrange.x , self.opcoes[i].Vrange.y, self.opcoes[i].Traio)

        -- ataque da torre laser
            for a = 1, 20 do
                if Range(self.opcoes[i].Traio, enemy.inimigos[a].Iraio, self.opcoes[i].Vrange, enemy.inimigos[a].IV) then
                    love.graphics.line(self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty - self.opcoes[i].Theight / 2, enemy.inimigos[a].IV.x, enemy.inimigos[a].IV.y)
                end
            end
        end
    end

    end
end