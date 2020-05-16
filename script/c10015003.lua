--Ardent Observer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STAR_SENTINEL)
	--creature
	aux.EnableCreatureAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--blocker
	aux.EnableBlocker(c)
	--skirmisher
	aux.EnableSkirmisher(c)
end
