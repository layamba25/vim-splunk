" Vim syntax file
" Language: Splunk configuration files
" Maintainer: Colby Williams <colbyw at gmail dot com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

setlocal iskeyword+=.
setlocal iskeyword+=:
setlocal iskeyword+=-

syn case match

syn match confComment /^#.*/ contains=confTodo oneline display
syn match confSpecComment /^\s.*/ contains=confTodo oneline display
syn match confSpecComment /^\*.*/ contains=confTodo oneline display

syn region confString start=/"/ skip="\\\"" end=/"/ oneline display contains=confNumber,confVar
syn region confString start=/`/             end=/`/ oneline display contains=confNumber,confVar
syn region confString start=/'/ skip="\\'"  end=/'/ oneline display contains=confNumber,confVar
syn match  confNumber /\v[+-]?\d+([ywdhsm]|m(on|ins?))(\@([ywdhs]|m(on|ins?))\d*)?>/
syn match  confNumber /\v[+-]?\d+(\.\d+)*>/
syn match  confNumber /\v<\d+[TGMK]B>/
syn match  confNumber /\v<\d+(k)?b>/
syn match  confPath   ,\v(^|\s|\=)\zs(file:|https?:|\$\k+)?(/+\k+)+(:\d+)?,
syn match  confPath   ,\v(^|\s|\=)\zsvolume:\k+(/+\k+)+,
syn match  confVar    /\$\k\+\$/

syn keyword confBoolean on off t[rue] f[alse] T[rue] F[alse]
syn keyword confTodo FIXME[:] NOTE[:] TODO[:] contained

" Define generic stanzas
syn match confGenericStanzas display contained /\v[^\]]+/

" Define stanzas
syn region confStanza matchgroup=confStanzaStart start=/^\[/ matchgroup=confStanzaEnd end=/\]/ oneline transparent contains=@confStanzas

" Group clusters
syn cluster confStanzas contains=confOutputsStanzas,confGenericStanzas

" outputs.conf
syn match   confOutputsStanzas contained /\v<(default|indexAndForward|indexer_discovery:[^]]+|syslog(:[^]]+)?|tcpout(-server:\/\/\S+:\d+|:[^]]+)?)>/
syn match   confOutputs /\v<^(ackTimeoutOnShutdown|autoLB(Frequency|Volume)|backoffOnFailure|block(OnCloning|WarnThreshold)|channel(Reap(Interval|Lowater)|TTL))>/
syn match   confOutputs /\v<^(cipherSuite|clientCert|compressed|(connection|read|write)Timeout|(cxn|rcv|send)_timeout|defaultGroup|(dnsResolution|secsInFailure)Interval|drop(Cloned)?EventsOnQueueFull)>/
syn match   confOutputs /\v<^(ecdhCurves|forceTimebasedAutoLB|forwardedindex\.(\d+\.(black|white)list|filter\.disable)|heartbeatFrequency|index(AndForward|erDiscovery)?)>/
syn match   confOutputs /\v<^(master_uri|max(ConnectionsPerIndexer|(Event|Queue)Size|FailuresPerInterval)|negotiate(NewProtocol|ProtocolLevel)|pass4SymmKey)>/
syn match   confOutputs /\v<^(priority|selectiveIndexing|sendCookedData|server|socks(Password|ResolveDNS|Server|Username)|syslogSourceType|tcpSendBufSz)>/
syn match   confOutputs /\v<^(ssl((Alt|Common)NameToCheck|(Cert|RootCA)Path|Cipher|Password|QuietShutdown|VerifyServerCert|Versions))>/
syn match   confOutputs /\v<^(timestampformat|tlsHostname|token|type|use(ACK|ClientSSLCompression))>/

syn match   confOutputsConstants /\v<(auto|NO_PRI|tcp|udp)$>/

" Highlight definitions (generic)
hi def link confComment Comment
hi def link confSpecComment Error
hi def link confBoolean Boolean
hi def link confTodo Todo

" Other highlight
hi def link confString String
hi def link confNumber Number
hi def link confPath   Number
hi def link confVar    PreProc

hi def link confStanzaStart Delimiter
hi def link confstanzaEnd Delimiter

" Highlight for stanzas
hi def link confStanza Function
hi def link confGenericStanzas Constant
hi def link confOutputsStanzas Identifier
hi def link confOutputs Keyword
hi def link confOutputsConstants Constant
