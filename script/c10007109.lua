--Tatsurion the Champion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--to mana zone, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DecktopSendtoMZoneTarget(PLAYER_SELF),scard.op1)
end
--to mana zone, get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc:IsCivilization(CIVILIZATION_FIRE) then return end
	local c=e:GetHandler()
	--power up
	aux.AddTempEffectUpdatePower(c,c,1,2000)
	--fast attack
	aux.AddTempEffectCustom(c,c,2,EFFECT_FAST_ATTACK)
end
