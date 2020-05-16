--Railgun Raptor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,3000)
end
