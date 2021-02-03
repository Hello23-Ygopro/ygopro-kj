--Cloudweave
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--to shield zone
	aux.AddSpellCastEffect(c,0,nil,scard.op1)
end
--to shield zone
function scard.cfilter(c)
	return c:IsFaceup() and c:IsEvolution()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoSZone(tp,1)
	if Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,1,nil) then
		Duel.SendDecktoSZone(tp,1)
	end
end
