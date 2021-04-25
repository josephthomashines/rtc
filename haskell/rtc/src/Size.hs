module Size where

class (Num t, Fractional t) => Size t where
  magnitude :: t -> Rational

  normalize :: t -> t
  normalize x = x / (fromRational $ magnitude x)
