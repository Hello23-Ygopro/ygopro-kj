--Chaotic Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,scard.con1)
end
--power up
function scard.con1(e)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsFaceup() and tc:IsHasEffect(EFFECT_BLOCKER)
end
