-- | Monad homomorphisms.

{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeOperators #-}

module Test.Monad.Morph where

import Test.Checkers

-- | Natural transformation.
type m ~> n = forall t. m t -> n t

bindHom
  :: forall m n a b
  .  (Monad m, Monad n)
  => (m ~> n) -> m a -> (a -> m b) -> Equation (n b)
bindHom hom m k = hom (m >>= k) :=: (hom m >>= hom . k)

returnHom
  :: forall m n a
  .  (Monad m, Monad n)
  => (m ~> n) -> a -> Equation (n a)
returnHom hom a = hom (return a) :=: return a
