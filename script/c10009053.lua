--Plasma Pincer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKY_WEAVER,RACE_MELT_WARRIOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000)
	--untap
	aux.EnableTurnEndSelfUntap(c)
end
