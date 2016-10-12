! function(t) {
    "use strict";
    t.module("fx.animations.assist", []).factory("Assist", ["$filter", "$window", "$timeout", "$rootScope", function(n, a, r, i) {
        return {
            emit: function(t, n, a) {
                i.$broadcast(n + ":" + a)
            },
            parseClassList: function(r, i) {
                var e, o = r[0].classList,
                    s = {
                        trigger: !1,
                        duration: .3,
                        ease: a.Back
                    };
                return t.forEach(o, function(t) {
                    "fx-easing" === t.slice(0, 9) && (e = t.slice(10), s.ease = a[n("cap")(e)] || a.Elastic), "fx-trigger" === t && (s.trigger = !0), "fx-speed" === t.slice(0, 8) && (s.duration = parseInt(t.slice(9)) / 1e3)
                }), i ? {
                    ease: s.ease,
                    speed: s.duration
                } : s
            },
            addTimer: function(t, n, a) {
                var i = this,
                    e = t.stagger ? 3 * t.duration * 1e3 : 1e3 * t.duration,
                    o = r(function() {
                        t.trigger && i.emit(n, t.animation, t.motion), a()
                    }, e);
                n.data(t.timeoutKey, o)
            },
            removeTimer: function(t, n, a) {
                r.cancel(a), t.removeData(n)
            }
        }
    }]).filter("cap", [function() {
        return function(t) {
            return t.charAt(0).toUpperCase() + t.slice(1)
        }
    }])
}(angular),
function(t, n, a) {
    "use strict";
    var r = "$$fxTimer";
    t.module("fx.animations.create", ["fx.animations.assist"]).factory("FadeAnimation", ["$timeout", "$window", "Assist", function(t, a, i) {
        return function(t) {
            var a = t.enter,
                e = t.leave,
                o = t.inverse || t.leave,
                s = t.animation;
            this.enter = function(t, o) {
                var m = i.parseClassList(t);
                return m.motion = "enter", m.animation = s, m.timeoutKey = r, i.addTimer(m, t, o), a.ease = m.ease.easeOut, n.set(t, e), n.to(t, m.duration, a),
                    function(n) {
                        var a = t.data(r);
                        n && a && i.removeTimer(t, r, a)
                    }
            }, this.leave = function(t, e) {
                var m = i.parseClassList(t);
                return m.motion = "leave", m.animation = s, m.timeoutKey = r, i.addTimer(m, t, e), o.ease = m.ease.easeIn, n.set(t, a), n.to(t, m.duration, o),
                    function(n) {
                        var a = t.data(r);
                        n && a && i.removeTimer(t, r, a)
                    }
            }, this.move = this.enter, this.addClass = function(t, a, e) {
                if (a) {
                    var m = i.parseClassList(t);
                    return m.motion = "enter", m.animation = s, m.timeoutKey = r, i.addTimer(m, t, e), n.to(t, m.duration, o),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                e()
            }, this.removeClass = function(t, o, m) {
                if (o) {
                    var f = i.parseClassList(t);
                    return f.motion = "leave", f.animation = s, f.timeoutKey = r, n.set(t, e), n.to(t, f.duration, a),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                m()
            }
        }
    }]).factory("BounceAnimation", ["$timeout", "$window", "Assist", function(t, n, i) {
        return function(t) {
            var n = t.first,
                e = t.mid,
                o = t.third,
                s = t.end,
                m = t.animation,
                f = .1;
            this.enter = function(t, f) {
                var u = i.parseClassList(t);
                u.motion = "enter", u.animation = m, u.timeoutKey = r, u.stagger = !0, i.addTimer(u, t, f);
                var c = new a;
                return c.to(t, .01, n), c.to(t, u.duration, e), c.to(t, u.duration, o), c.to(t, u.duration, s),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.leave = function(t, u) {
                var c = i.parseClassList(t);
                c.motion = "leave", c.animation = m, c.timeoutKey = r, c.stagger = !0, i.addTimer(c, t, u);
                var d = new a;
                return d.to(t, f, s), d.to(t, c.duration, o), d.to(t, c.duration, e), d.to(t, c.duration, n),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.move = this.enter, this.addClass = function(t, u, c) {
                if (u) {
                    var d = i.parseClassList(t);
                    d.motion = "enter", d.animation = m, d.timeoutKey = r, i.addTimer(d, t, c);
                    var l = new a;
                    return l.to(t, f, s), l.to(t, d.duration, o), l.to(t, d.duration, e), l.to(t, d.duration, n),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                c()
            }, this.removeClass = function(t, u, c) {
                if (u) {
                    var d = i.parseClassList(t);
                    d.motion = "leave", d.animation = m, d.timeoutKey = r;
                    var l = new a;
                    return l.to(t, f, n), l.to(t, d.duration, e), l.to(t, d.duration, o), l.to(t, d.duration, s),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                c()
            }
        }
    }]).factory("RotateAnimation", ["$timeout", "$window", "Assist", function(t, a, i) {
        return function(t) {
            var a = t.start,
                e = t.end,
                o = t.inverse,
                s = t.animation;
            this.enter = function(t, o) {
                var m = i.parseClassList(t);
                return m.motion = "enter", m.animation = s, m.timeoutKey = r, e.ease = m.ease.easeOut, i.addTimer(m, t, o), n.set(t, a), n.to(t, m.duration, e),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.leave = function(t, a) {
                var m = i.parseClassList(t);
                return m.motion = "leave", m.animation = s, m.timeoutKey = r, o.ease = m.ease.easeIn, i.addTimer(m, t, a), n.set(t, e), n.to(t, m.duration, o),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.move = this.enter, this.addClass = function(t, o, m) {
                if (o) {
                    var f = i.parseClassList(t);
                    return f.motion = "enter", f.animation = s, f.timeoutKey = r, i.addTimer(f, t, m), n.set(t, e), n.to(t, f.duration, a),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                m()
            }, this.removeClass = function(t, o, m) {
                if (o) {
                    var f = i.parseClassList(t);
                    return f.motion = "enter", f.animation = s, f.timeoutKey = r, i.addTimer(f, t, m), n.set(t, a), n.to(t, f.duration, e),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                m()
            }
        }
    }]).factory("ZoomAnimation", ["$timeout", "$window", "Assist", function(t, a, i) {
        return function(t) {
            var a = t.start,
                e = t.end,
                o = t.animation;
            this.enter = function(t, s) {
                var m = i.parseClassList(t);
                return m.motion = "enter", m.animation = o, m.timeoutKey = r, e.ease = m.ease.easeOut, i.addTimer(m, t, s), n.set(t, a), n.to(t, m.duration, e),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.leave = function(t, s) {
                var m = i.parseClassList(t);
                return m.motion = "leave", m.animation = o, m.timeoutKey = r, a.ease = m.ease.easeIn, i.addTimer(m, t, s), n.set(t, e), n.to(t, m.duration, a),
                    function(n) {
                        if (n) {
                            var a = t.data(r);
                            a && i.removeTimer(t, r, a)
                        }
                    }
            }, this.move = this.enter, this.removeClass = function(t, s, m) {
                if ("ng-hide" === s) {
                    var f = i.parseClassList(t);
                    return f.motion = "leave", f.animation = o, f.timeoutKey = r, i.addTimer(f, t, m), n.set(t, a), n.to(t, f.duration, e),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                m()
            }, this.addClass = function(t, s, m) {
                if ("ng-hide" === s) {
                    var f = i.parseClassList(t);
                    return f.motion = "enter", f.animation = o, f.timeoutKey = r, i.addTimer(f, t, m), n.set(t, e), n.to(t, f.duration, a),
                        function(n) {
                            if (n) {
                                var a = t.data(r);
                                a && i.removeTimer(t, r, a)
                            }
                        }
                }
                m()
            }
        }
    }]).factory("Flip3d", ["$window", function(a) {
        return function(r) {
            var i = r.axis,
                e = "fx-flip" + i;
            this.addClass = function(i, o, s) {
                var m = t.element(i.children()[0]),
                    f = function() {
                        return s()
                    };
                o === e ? (r.transform.ease = a.Bounce.easeOut, r.transform.onComplete = f, n.to(m, r.duration, r.transform)) : s()
            }, this.removeClass = function(i, o, s) {
                var m = t.element(i.children()[0]),
                    f = function() {
                        return s()
                    };
                o === e ? (r.reset.ease = a.Bounce.easeOut, r.reset.onComplete = f, n.to(m, r.duration, r.reset)) : s()
            }
        }
    }])
}(angular, TweenMax, TimelineMax),
function(t) {
    "use strict";
    t.module("fx.animations.bounces", ["fx.animations.create"]).animation(".fx-bounce-normal", ["BounceAnimation", function(t) {
        var n = {
            first: {
                opacity: 0,
                transform: "scale(.3)"
            },
            mid: {
                opacity: 1,
                transform: "scale(1.05)"
            },
            third: {
                transform: "scale(.9)"
            },
            end: {
                opacity: 1,
                transform: "scale(1)"
            },
            animation: "bounce-normal"
        };
        return new t(n)
    }]).animation(".fx-bounce-down", ["BounceAnimation", function(t) {
        var n = {
            first: {
                opacity: 0,
                transform: "translateY(-2000px)"
            },
            mid: {
                opacity: 1,
                transform: "translateY(30px)"
            },
            third: {
                transform: "translateY(-10px)"
            },
            end: {
                transform: "translateY(0)"
            },
            animation: "bounce-down"
        };
        return new t(n)
    }]).animation(".fx-bounce-left", ["BounceAnimation", function(t) {
        var n = {
            first: {
                opacity: 0,
                transform: "translateX(-2000px)"
            },
            mid: {
                opacity: 1,
                transform: "translateX(30px)"
            },
            third: {
                transform: "translateX(-10px)"
            },
            end: {
                transform: "translateX(0)"
            },
            animation: "bounce-left"
        };
        return new t(n)
    }]).animation(".fx-bounce-up", ["BounceAnimation", function(t) {
        var n = {
            first: {
                opacity: 0,
                transform: "translateY(2000px)"
            },
            mid: {
                opacity: 1,
                transform: "translateY(-30px)"
            },
            third: {
                transform: "translateY(10px)"
            },
            end: {
                transform: "translateY(0)"
            },
            animation: "bounce-up"
        };
        return new t(n)
    }]).animation(".fx-bounce-right", ["BounceAnimation", function(t) {
        var n = {
            first: {
                opacity: 0,
                transform: "translateX(2000px)"
            },
            mid: {
                opacity: 1,
                transform: "translateX(-30px)"
            },
            third: {
                transform: "translateX(10px)"
            },
            end: {
                transform: "translateX(0)"
            },
            animation: "bounce-right"
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    t.module("fx.animations.fades", ["fx.animations.create"]).animation(".fx-fade-normal", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1
            },
            leave: {
                opacity: 0
            },
            animation: "fade-normal"
        };
        return new t(n)
    }]).animation(".fx-fade-down", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateY(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateY(-20px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateY(20px)"
            },
            animation: "fade-down"
        };
        return new t(n)
    }]).animation(".fx-fade-down-big", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateY(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateY(-2000px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateY(2000px)"
            },
            animation: "fade-down-big"
        };
        return new t(n)
    }]).animation(".fx-fade-left", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateX(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateX(-20px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateX(20px)"
            },
            animation: "fade-left"
        };
        return new t(n)
    }]).animation(".fx-fade-left-big", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateX(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateX(-2000px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateX(2000px)"
            },
            animation: "fade-left-big"
        };
        return new t(n)
    }]).animation(".fx-fade-right", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateX(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateX(20px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateX(-20px)"
            },
            animation: "fade-right"
        };
        return new t(n)
    }]).animation(".fx-fade-right-big", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateX(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateX(2000px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateX(-2000px)"
            },
            animation: "fade-right-big"
        };
        return new t(n)
    }]).animation(".fx-fade-up", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateY(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateY(20px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateY(-20px)"
            },
            animation: "fade-up"
        };
        return new t(n)
    }]).animation(".fx-fade-up-big", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: 1,
                transform: "translateY(0)"
            },
            leave: {
                opacity: 0,
                transform: "translateY(2000px)"
            },
            inverse: {
                opacity: 0,
                transform: "translateY(-2000px)"
            },
            animation: "fade-up-big"
        };
        return new t(n)
    }]).animation(".fx-fade-overlay", ["FadeAnimation", function(t) {
        var n = {
            enter: {
                opacity: .7
            },
            leave: {
                opacity: 0
            },
            inverse: {
                opacity: 0
            },
            animation: "fade-overlay"
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    t.module("fx.animations.rotations", ["fx.animations.create"]).animation(".fx-rotate-counterclock", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "center center",
                transform: "rotate(-200deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "center center",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "center center",
                transform: "rotate(200deg)"
            },
            animation: "rotate-counterclock"
        };
        return new t(n)
    }]).animation(".fx-rotate-clock", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "center center",
                transform: "rotate(200deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "center center",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "center center",
                transform: "rotate(-200deg)"
            },
            animation: "rotate-clock"
        };
        return new t(n)
    }]).animation(".fx-rotate-clock-left", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "left bottom",
                transform: "rotate(-90deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "left bottom",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "left bottom",
                transform: "rotate(90deg)"
            },
            animation: "rotate-clock-left"
        };
        return new t(n)
    }]).animation(".fx-rotate-counterclock-right", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "right bottom",
                transform: "rotate(90deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "right bottom",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "right bottom",
                transform: "rotate(-90deg)"
            },
            animation: "rotate-counterclock-right"
        };
        return new t(n)
    }]).animation(".fx-rotate-counterclock-up", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "left bottom",
                transform: "rotate(90deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "left bottom",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "left bottom",
                transform: "rotate(-90deg)"
            },
            animation: "rotate-counterclock-up"
        };
        return new t(n)
    }]).animation(".fx-rotate-clock-up", ["RotateAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transformOrigin: "right bottom",
                transform: "rotate(-90deg)"
            },
            end: {
                opacity: 1,
                transformOrigin: "right bottom",
                transform: "rotate(0)"
            },
            inverse: {
                opacity: 0,
                transformOrigin: "right bottom",
                transform: "rotate(90deg)"
            },
            animation: "rotate-clock-up"
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    t.module("fx.animations.zooms", ["fx.animations.create"]).animation(".fx-zoom-normal", ["ZoomAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transform: "scale(.3)"
            },
            end: {
                opacity: 1,
                transform: "scale(1)"
            },
            animation: "zoom-normal"
        };
        return new t(n)
    }]).animation(".fx-zoom-down", ["ZoomAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transform: "scale(.1) translateY(-2000px)"
            },
            end: {
                opacity: 1,
                transform: "scale(1) translateY(0)"
            },
            animation: "zoom-down"
        };
        return new t(n)
    }]).animation(".fx-zoom-up", ["ZoomAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transform: "scale(.1) translateY(2000px)"
            },
            end: {
                opacity: 1,
                transform: "scale(1) translateY(0)"
            },
            animation: "zoom-up"
        };
        return new t(n)
    }]).animation(".fx-zoom-right", ["ZoomAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transform: "scale(.1) translateX(2000px)"
            },
            end: {
                opacity: 1,
                transform: "scale(1) translateX(0)"
            },
            animation: "zoom-right"
        };
        return new t(n)
    }]).animation(".fx-zoom-left", ["ZoomAnimation", function(t) {
        var n = {
            start: {
                opacity: 0,
                transform: "scale(.1) translateX(-2000px)"
            },
            end: {
                opacity: 1,
                transform: "scale(1) translateX(0)"
            },
            animation: "zoom-left"
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    var n = "$$fxtimer";
    t.module("fx.transitions.assist", []).factory("TransAssist", ["$timeout", function(t) {
        function a(a, r, i) {
            var e = t(function() {
                i()
            }, 1e3 * r + 50);
            a.data(n, e)
        }

        function r(a) {
            var r = a.data(n);
            r && (a.css("z-index", "-1"), t.cancel(r), a.removeData(n))
        }
        return {
            addTimer: a,
            removeTimer: r
        }
    }])
}(angular),
function(t, n) {
    "use strict";

    function a(t, n) {
        t.css("position", "absolute"), n && "leave" === n ? t.css("z-index", "9999px") : t.css("z-index", "1000px")
    }

    function r(t, n) {
        var a = {
                position: "relative",
                width: "100%",
                height: "100%",
                "-webkit-perspective": "500px",
                "-moz-perspective": "500px",
                "-o-perspective": "500px",
                perspective: "500px"
            },
            r = {
                overflow: "hidden",
                "-webkit-backface-visibility": "hidden",
                "-moz-backface-visibility": "hidden",
                "backface-visibility": "hidden",
                "-webkit-transform": "translate3d(0, 0, 0)",
                "-moz-transform": "translate3d(0, 0, 0)",
                transform: "translate3d(0, 0, 0),",
                " -webkit-transform-style": "preserve-3d",
                "-moz-transform-style": "preserve-3d",
                "transform-style": "preserve-3d"
            };
        t.css(a), n.css(r)
    }
    t.module("fx.transitions.create", ["fx.transitions.assist", "fx.animations.assist"]).factory("SlideTransition", ["TransAssist", "Assist", function(t, r) {
        var i;
        return function(e) {
            e.from ? this.enter = function(o, s) {
                var m;
                return a(o), m = r.parseClassList(o, !0), e.from.ease = m.ease.easeInOut, e.duration = m.speed, t.addTimer(o, e.duration, s), i = new n, i.from(o, e.duration, e.from),
                    function(n) {
                        n && t.removeTimer(o)
                    }
            } : !e.from && e.to && (this.leave = function(o, s) {
                var m;
                return a(o), m = r.parseClassList(o, !0), e.to.ease = m.ease.easeInOut, e.duration = m.speed, t.addTimer(o, e.duration, s), i = new n, i.to(o, e.duration, e.to),
                    function(n) {
                        n && t.removeTimer(o)
                    }
            })
        }
    }]).factory("RotationTransition", ["TransAssist", "Assist", "$compile", function(i, e, o) {
        var s;
        return function(m) {
            this[m.when] = function(f, u) {
                var c, d;
                return d = o("<div></div>")(f.scope()), a(f), r(d, f), t.element(d).append(f[0].outerHTML), c = e.parseClassList(f, !0), m.from.ease = c.ease.easeOut, m.duration = c.duration, i.addTimer(f, m.duration, u), s = new n, s.from(f, 1, m.from).to(f, 1, m.to),
                    function(t) {
                        t && i.removeTimer(f)
                    }
            }
        }
    }])
}(angular, TimelineMax),
function() {
    "use strict";
    angular.module("fx.transitions.view", []).directive("fxAnimate", ["$injector", function(t) {
        return {
            link: function(n, a) {
                function r(t, n) {
                    angular.forEach(t, function(t, a) {
                        "ease" === a && (t = "fx-easing-" + t), "speed" === a && (t = "fx-speed-" + t), n.addClass(t)
                    })
                }
                var i, e;
                t.has("$state") && (i = t.get("$state")), t.has("$route") && (e = t.get("$route"));
                var o;
                if (i && i.current.animation && e && e.current && e.current.$$route && e.current.$$route.animation) throw new Error("You can only add animations on either $state or $route");
                i && (o = i.current.animation), e && e.current && (o = e.current.$$route.animation), r(o, a)
            }
        }
    }])
}(),
function(t) {
    "use strict";
    t.module("fx.transitions.rotations", ["fx.transitions.create"]).animation(".rotate-out-right", ["RotationTransition", function(t) {
        var n = {
            from: {
                transform: "rotateY(15deg)",
                opacity: ".8"
            },
            to: {
                transform: "scale(0.8) translateZ(-200px)",
                opacity: "0"
            },
            when: "leave",
            duration: .5
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    t.module("fx.transitions.scales", ["fx.transitions.create"]).animation(".shrink-in", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0",
                transform: "translateZ(0) scale(1.2)"
            },
            duration: .5
        };
        return new t(n)
    }]).animation(".shrink-out", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0",
                transform: "translateZ(0) scale(.8)"
            },
            duration: .5
        };
        return new t(n)
    }]).animation(".grow-in", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0",
                transform: "translateZ(0) scale(.8)"
            },
            duration: .5
        };
        return new t(n)
    }]).animation(".grow-out", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0",
                transform: "translateZ(0) scale(1.2)"
            },
            duration: .5
        };
        return new t(n)
    }])
}(angular),
function(t) {
    "use strict";
    t.module("fx.transitions.slides", ["fx.transitions.create"]).animation(".slide-in-left", ["SlideTransition", function(t) {
        var n = {
            from: {
                transform: "translateZ(0) translateX(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-left", ["SlideTransition", function(t) {
        var n = {
            to: {
                transform: "translateZ(0) translateX(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-right", ["SlideTransition", function(t) {
        var n = {
            from: {
                transform: "translateZ(0) translateX(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-right", ["SlideTransition", function(t) {
        var n = {
            to: {
                transform: "translateZ(0) translateX(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-down", ["SlideTransition", function(t) {
        var n = {
            from: {
                transform: "translateZ(0) translateY(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-down", ["SlideTransition", function(t) {
        var n = {
            to: {
                transform: "translateZ(0) translateY(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-up", ["SlideTransition", function(t) {
        var n = {
            from: {
                transform: "translateZ(0) translateY(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-up", ["SlideTransition", function(t) {
        var n = {
            to: {
                transform: "translateZ(0) translateY(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-left-fade", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0.3",
                transform: "translateZ(0) translateX(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-left-fade", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0.3",
                transform: "translateZ(0) translateX(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-right-fade", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0.3",
                transform: "translateZ(0) translateX(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-right-fade", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0.3",
                transform: "translateZ(0) translateX(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-down-fade", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0.3",
                transform: "translateZ(0) translateY(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-down-fade", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0.3",
                transform: "translateZ(0) translateY(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-in-up-fade", ["SlideTransition", function(t) {
        var n = {
            from: {
                opacity: "0.3",
                transform: "translateZ(0) translateY(100%)"
            },
            duration: 2
        };
        return new t(n)
    }]).animation(".slide-out-up-fade", ["SlideTransition", function(t) {
        var n = {
            to: {
                opacity: "0.3",
                transform: "translateZ(0) translateY(-100%)"
            },
            duration: 2
        };
        return new t(n)
    }])
}(angular),
function(t, n) {
    "use strict";
    t.module("fx.transitions.specials", []).animation(".fx-fall-out", function() {
        return {
            leave: function(t, a) {
                t.css("z-index", "9999");
                var r = new n({
                    onComplete: a
                });
                r.to(t, {
                    transform: "rotateZ(0deg)"
                }).to(t, .1, {
                    transform: "rotateZ(10deg)"
                }).to(t, .3, {
                    transform: "rotateZ(17deg)"
                }).to(t, .5, {
                    transform: "rotateZ(15deg)"
                }).to(t, .2, {
                    transform: "translateY(100%) rotateZ(17deg)"
                })
            }
        }
    })
}(angular, TimelineMax),
function(t) {
    "use strict";
    t.module("fx.animations", ["fx.animations.fades", "fx.animations.bounces", "fx.animations.rotations", "fx.animations.zooms"]), t.module("fx.transitions", ["fx.transitions.slides", "fx.transitions.scales", "fx.transitions.rotations", "fx.transitions.specials", "fx.transitions.view"]), t.module("ngFx", ["fx.animations", "fx.transitions", "ngAnimate"])
}(angular);