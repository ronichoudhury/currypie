import Network.Socket

main :: IO ()
main = do
    sock <- socket AF_INET Stream defaultProtocol
    setSocketOption sock ReuseAddr 1
    bindSocket sock (SockAddrInet 9000 iNADDR_ANY)
    listen sock 2
    mainLoop sock

mainLoop :: Socket -> IO ()
mainLoop sock = do
    conn <- accept sock
    runConn conn
    mainLoop sock

runConn :: (Socket, SockAddr) -> IO ()
runConn (sock, _) = do
    h <- socketToHandle sock ReadWriteMode
    hSetBuffering h NoBuffering
    hPutStrLn h "Hi!"
    hClose sock
