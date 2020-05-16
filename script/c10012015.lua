--Neural Helix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (draw or to hand, to shield zone)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (draw or to hand, to shield zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsPlayerCanDraw(tp,1)
	local b2=Duel.IsExistingMatchingCard(aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,1,nil)
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Draw(tp,2,REASON_EFFECT)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=Duel.SelectMatchingCard(tp,aux.ShieldZoneFilter(Card.IsAbleToHand),tp,LOCATION_SZONE,0,0,1,nil)
		if g1:GetCount()==0 then return end
		Duel.HintSelection(g1)
		if Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)==0 then return end
		Duel.ShuffleHand(tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOSZONE)
		local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToSZone,tp,LOCATION_HAND,0,1,1,e:GetHandler())
		if g2:GetCount()==0 then return end
		Duel.SendtoSZone(g2)
	end
end
