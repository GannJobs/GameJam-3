Campos = Classe:extend()

function Campos:new()
    self.width = 50
    self.height = 50
    self.x = love.graphics.getWidth() / 2 - self.width / 2 - 160
    self.y = self.height + 150

    self.selecao = false
    self.Nselecionando = true
    self.raioS = 100

    self.opcoes = {}

    for i = 1, 1 do
        self.opcoes[i] = {
            Tx = self.x,
            Ty = self.y - self.raioS,
            Twidth = 50,
            Theight = 50,
            Traio = 0,
            criada = false,
            Vrange = Vetor(0,0)
        }
    end

    cont = 0
end

function Campos:update(dt)

    -- criacao de torre

    if MouseSelection(self.width, self.height, self.x, self.y) then
        print("encima da casa")
        if love.mouse.isDown(1, 2, 3) then
            print("abrir selecao")
            self.selecao = true
            self.Nselecionando = false
        end
    else
        if love.mouse.isDown(1, 2, 3) and self.Nselecionando then
            print("fechar selecao")
            self.selecao = false
        end
    end

    if not (self.Nselecionando) then
        if MouseSelection(self.opcoes[1].Twidth, self.opcoes[1].Theight, self.opcoes[1].Tx, self.opcoes[1].Ty) then
            print("encima da escolha")
            if love.mouse.isDown(1, 2, 3) then
                print("torre criada")
                self.opcoes[1] = {
                    Tx = self.x,
                    Ty = self.y,
                    Twidth = 50,
                    Theight = 50,
                    Traio = 200,
                    criada = true,
                    Vrange = Vetor(self.x + self.width/2, self.y + self.height/2)
                }
                self.selecionando = false
                self.selecao = false
                print("selecao fechada")
            end
        end
    end

    -- ataque de torre

    cont = cont + dt

    for i = 1, 1 do
        if Range(self.opcoes[i].Traio, enemy.raio, self.opcoes[i].Vrange, enemy.V) then
            print("no range")
            if cont > 1 and enemy.vida > 0 then -- damage
                enemy.vida = enemy.vida - 5
                cont = 0
            end
        end
    end

end

function Campos:draw()

    -- desenha slots de torre
    local y = 0
    local y2 = 0
    for i = 1, 1 do
        love.graphics.rectangle("line", self.x, self.y + y, self.width, self.height)
        y = y + 200
    end
    -- for a = 1, 3 do
    --     love.graphics.rectangle("line", love.graphics.getWidth() / 2 + self.width / 2 + 110, self.y + y2, self.width,self.height)
    --     y2 = y2 + 200
    -- end

    -- desenha a seleçao dos tipos de torre
    if self.selecao then
        -- raio de escolha
        love.graphics.circle("line", self.x + self.width / 2, self.y + self.height / 2, self.raioS)
        -- opçoes
        for i = 1, 1 do
            love.graphics.rectangle("fill", self.opcoes[i].Tx, self.opcoes[i].Ty, self.opcoes[i].Twidth,
                self.opcoes[i].Theight)
        end
    end

    -- desenha a torre criada

    for i = 1, 1 do
        if self.opcoes[i].criada then
            -- torre
            love.graphics.rectangle("fill", self.opcoes[i].Tx, self.opcoes[i].Ty, self.opcoes[i].Twidth, self.opcoes[i].Theight)
            love.graphics.rectangle("fill", self.opcoes[i].Tx, self.opcoes[i].Ty - self.opcoes[i].Theight, self.opcoes[i].Twidth, self.opcoes[i].Theight)

            -- range
            -- love.graphics.circle("line", self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty + self.opcoes[i].Theight / 2, self.opcoes[i].Traio)
            love.graphics.circle("line", self.opcoes[i].Vrange.x , self.opcoes[i].Vrange.y, self.opcoes[i].Traio)
            love.graphics.setColor(255, 0, 0)

            -- olho da torre
            love.graphics.circle("fill", self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty - self.opcoes[i].Theight / 2, 5)
        end
    end

    -- desenha o ataque da torre

    for i = 1, 1 do
        if self.opcoes[i].criada then
            if Range(self.opcoes[i].Traio, enemy.raio, self.opcoes[i].Vrange, enemy.V) then
                love.graphics.line(self.opcoes[i].Tx + self.opcoes[i].Twidth / 2, self.opcoes[i].Ty - self.opcoes[i].Theight / 2, enemy.V.x, enemy.V.y)
            end
        end
    end

end
