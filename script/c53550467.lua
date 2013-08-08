--Noble Knight Drystan
function c53550467.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c53550467.con)
	e1:SetTarget(c53550467.tg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetCondition(c53550467.con)
	e2:SetTarget(c53550467.tg)
	e2:SetValue(c53550467.efval)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(53550467,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CHAIN_UNIQUE)
	e3:SetCode(EVENT_EQUIP)
	e3:SetCondition(c53550467.descon)
	e3:SetCost(c53550467.descost)
	e3:SetTarget(c53550467.destg)
	e3:SetOperation(c53550467.desop)
	c:RegisterEffect(e3)
end
function c53550467.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107a)
end
function c53550467.con(e)
	return Duel.IsExistingMatchingCard(c53550467.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c53550467.tg(e,c)
	return c~=e:GetHandler() and c:IsFaceup() and c:IsAttackBelow(1800)
end
function c53550467.efval(e,re,tp)
	return e:GetHandlerPlayer()~=tp
end
function c53550467.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSetCard,1,nil,0x207a)
end
function c53550467.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,53550467)==0 end
	Duel.RegisterFlagEffect(tp,53550467,RESET_PHASE+PHASE_END,0,1)
end
function c53550467.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c53550467.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c53550467.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c53550467.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c53550467.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
