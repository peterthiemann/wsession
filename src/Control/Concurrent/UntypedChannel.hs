module Control.Concurrent.UntypedChannel where

-- adapted from Dominic Orchard's repository orchard-sessions-in-haskell

import Unsafe.Coerce
import Control.Concurrent.MVar (MVar, putMVar, takeMVar, newEmptyMVar)
import qualified Control.Concurrent as Conc

data Channel = Chan { sendOn :: MVar Integer, recvOn :: MVar Integer }
data CPair = CPair Channel Channel

newChan :: IO CPair
newChan = do
  fore <- newEmptyMVar
  back <- newEmptyMVar
  return (CPair (Chan fore back) (Chan back fore))

primSend :: Channel -> a -> IO ()
primSend ch = putMVar (unsafeCoerce (sendOn ch))

primRecv :: Channel -> IO a
primRecv ch = takeMVar (unsafeCoerce (recvOn ch))

primClose :: Channel -> IO ()
primClose (Chan sendOn recvOn) = return ()

primFork :: IO () -> IO ()
primFork io = do
  _ <- Conc.forkIO io
  return ()


