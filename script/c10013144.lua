--Snarling Craghorn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TUSKER)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.SelfBattlingCondition)
end
