--Cassiopeia Starborn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CELESTIAL_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--tap, get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
end
--tap, get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	Duel.Tap(g1,REASON_EFFECT)
	local g2=Duel.GetOperatedGroup()
	local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
	for tc in aux.Next(g2) do
		--do not untap
		aux.AddTempEffectCustom(e:GetHandler(),tc,1,EFFECT_DONOT_UNTAP_START_STEP,RESET_PHASE+PHASE_DRAW,reset_count)
	end
end
--[[
	Rulings
		Q: Can those creatures be untapped in other ways?
		A: Yes. Your opponent (or you) could use a spell or a creature's ability to untap any of those creatures, in which
		case the part of "Supernova" that tries to keep them tapped won't do anything. They'll untap as normal at the
		start of your opponent's future turns.
		https://kaijudo.fandom.com/wiki/Cassiopeia_Starborn/Rulings
]]
