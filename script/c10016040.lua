--Blade Spawn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_VOID_SPAWN,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--clash (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.ClashTarget(PLAYER_SELF),scard.op1)
end
--clash (get ability)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.Clash(tp) then return end
	local c=e:GetHandler()
	--fast attack
	aux.AddTempEffectCustom(c,c,1,EFFECT_FAST_ATTACK)
end
