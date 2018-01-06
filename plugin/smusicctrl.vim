if exists("loaded_simple_music_ctrl")
    finish
endif
let loaded_simple_music_ctrl = 1

" {{{
" 本地的音乐缓冲目录
" let g:SMC_music_cache_dir = expand("~/Music/CloudMusic")
" }}}

" commands {{{
command! SMCNext call SimpleMusicNext()
command! SMCPrev call SimpleMusicPrev()
command! SMCPlay call SimpleMusicPlay()
" }}}

" functions {{{
function! IsMusicProcessExists(type) abort " 音乐进程:1.深度音乐；2.网易云音乐；3.cmus {{{
    let querymsg=""
    if 1 == a:type
        let querymsg = 'pgrep deepin-music'
    elseif 2 == a:type
        let querymsg = 'pgrep netease-cloud-m'
    elseif 3 == a:type
        let querymsg = 'pgrep cmus'
    else
        return 0
    endif

    let result = system(querymsg)
    " echo result
    if 0==strlen(result)
        " 不存在
        return 0
    endif
    " 存在
    return 1
endfunction " }}}

function! SimpleMusicNext() abort " 下一首 {{{
    let next=""
    if 1==IsMusicProcessExists(1)
        let next='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.DeepinMusic /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next'
    elseif 1==IsMusicProcessExists(2)
        let next='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.netease-cloud-music /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next'
    elseif 1==IsMusicProcessExists(3)
        let next='cmus-remote -n'
    else
        return
    endif

    call system(next)
endfunction " }}}

function! SimpleMusicPrev() abort " 上一首 {{{
    let prev= ""
    if 1==IsMusicProcessExists(1)
        let prev='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.DeepinMusic /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous'
    elseif 1==IsMusicProcessExists(2)
        let prev='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.netease-cloud-music /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous'
    elseif 1==IsMusicProcessExists(3)
        " cmus这个切换存在问题
        let prev='cmus-remote -r'
    else
        return
    endif
    call system(prev)
endfunction " }}}

function! SimpleMusicPlay() abort " 暂停或播放 {{{
    let play=""
    if 1==IsMusicProcessExists(1)
        let play='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.DeepinMusic /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause'
    elseif 1==IsMusicProcessExists(2)
        let play='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.netease-cloud-music /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause'
    elseif 1==IsMusicProcessExists(3)
        let play='cmus-remote -u'
    else
        return
    endif
    call system(play)
endfunction " }}}
" }}}

" key mappings {{

" }}
