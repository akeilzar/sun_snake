function _init()

	n = 1
	b = 1
	o = 0
	
	bg = 11
	
	cz = {}

	blank = 0
	a = 22
	
	text_colour = 11
	
	wc = 7

	--snake
		snake_x = {53, 52, 51}
		snake_y = {50, 50, 50}
		snake_colour = 0
		snake_dx = 1
		snake_dy = 0
		snake_draw = function ()
			for i=1,#snake_x do
				rectfill(snake_x[i], snake_y[i], snake_x[i]+1, snake_y[i]+1, snake_colour)
			end
		end
		snake_update = function ()
			add(snake_x,snake_x[1]+snake_dx,1)
			add(snake_y,snake_y[1]+snake_dy,1)
			deli(snake_x,#snake_x)
			deli(snake_y,#snake_y)
		end
		snake_btn = function ()
			if btn(⬆️) and snake_dy != 1 then
				bg = rnd(11)
				snake_dx = 0
				snake_dy = -1
			end
			if btn(⬅️) and snake_dx != 1 then
				bg = rnd(11)
				snake_dx = -1
				snake_dy = 0 
			end
			if btn(➡️) and snake_dx != -1 then
				bg = rnd(11)
				snake_dx = 1
				snake_dy = 0
			end
			if btn(⬇️) and snake_dy != -1 then
				bg = rnd(11)
				snake_dx = 0
				snake_dy = 1
			end
		end
		snake_extend = function ()
			add(snake_x,snake_x[1]+snake_dx,1)
			add(snake_y,snake_y[1]+snake_dy,1)
		end
		snake_self_hit = function ()
			for i=4,#snake_x do
				if snake_x[1] == snake_x[i] and snake_y[1] == snake_y[i] then
					stop()
				end
			end
		end
	--
	
	--particle
		particle_x = (max(11, ceil(rnd(115)))) % 115
		particle_y = (max(11, ceil(rnd(115)))) % 115
		particle_draw = function ()
			rectfill(particle_x,particle_y,particle_x+1,particle_y+1,snake_colour)
		end
		particle_update = function ()
			particle_x = max(11, ceil(rnd(115)))
			particle_y = max(11, ceil(rnd(115)))
		end
		particle_clash = function()
			if snake_x[1] < particle_x+1.2 then
				if snake_x[1] > particle_x-1.2 then
					if snake_y[1] < particle_y+1.2 then
						if snake_y[1] > particle_y-1.2 then
							particle_update()
							snake_extend()
							score += 1
						end
					end
				end
			end
		end
	--

end

score = 0

function _draw()
	cls()
	--circ(10,10,22,snake_colour)
	--circ(100,100,44,text_colour)
	--print(n, 2,116,3)
	--print(b, 118,16,wc)
	--print("ヲイオイウオイ",63,2,text_colour)
	--green bg
	rectfill(10,10,116,116,bg)
	print(score,2,2,text_colour)
	snake_draw()
	particle_draw()
	particle_clash()
	rectfill(0,0,blank,blank,0)
	--print(cz[0],16,16,snake_colour)
	--print(chr(rnd(128)),rnd(33),99,0)
	--print(chr(rnd(128)),rnd(99),rnd(99),0)
end

function _update60()
	snake_btn()
	snake_update()
	snake_self_hit()
	particle_y = (particle_y + rnd(0.5)-1) % 115
	a = rnd(100)
	if a > 99 then
		blank = 127
	end
	if a < 90 then
		blank = 0
	end
	if a < 95 then
		snake_colour = 0
	end
	if a > 95 then
		snake_colour = 11
	end
	if a < 60 then
		text_colour = 0
	end
	if a > 60 then
		text_colour = 11
	end
	if a > 80 then
		wc = 0
	end
	if a > 80 then
		wc = 3
	end
	if a < 80 then
		--bg = 8
	end
	if a > 80 then
		--bg = 0
	end
	--n = rnd(9999999999999)
	--b = ceil(rnd(9999999999999))
	for i=1,#snake_x do
		if snake_x[i] > 115 or snake_x[i] < 10 then 
			snake_x[i] = snake_x[i]%115
		end
		if snake_y[i] > 115 or snake_y[i] < 10 then 
			snake_y[i] = snake_y[i]%115
		end
	end
end
