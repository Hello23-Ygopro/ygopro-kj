--Keeper of Laws
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be targeted
	aux.EnableCannotBeTargeted(c,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
	--draw
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_OPPO,nil,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
--draw
function scard.con1(e)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,e:GetHandlerPlayer(),LOCATION_BZONE,0,1,e:GetHandler())
end
