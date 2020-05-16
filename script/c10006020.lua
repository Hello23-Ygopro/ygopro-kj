--Nix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FIRE_BIRD)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-1,nil,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsRaceCategory,RACECAT_DRAGON))
	--draw
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,aux.DrawTarget(PLAYER_SELF),scard.op1,nil,scard.con1)
end
--draw
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsRaceCategory(RACECAT_DRAGON) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,eg:GetCount(),REASON_EFFECT)
end
