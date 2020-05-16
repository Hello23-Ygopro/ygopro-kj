--Tatsurion the Brawler
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--untap, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_BE_BATTLE_TARGET,nil,nil,scard.op1,nil,scard.con1)
end
--untap, get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	return tc and tc:IsFaceup() and tc:IsControler(tp) and tc:IsNameCategory(NAMECAT_SCARADORABLE,NAMECAT_GLUURRGLE)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() then return end
	Duel.Untap(c,REASON_EFFECT)
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,5000)
end
