--Sparkspine Lizard
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--powerful attack
	aux.EnablePowerfulAttack(c,2000,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--fast attack, powerful attack
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCode(sid)
end
function scard.con1(e)
	return Duel.IsExistingMatchingCard(scard.cfilter,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
