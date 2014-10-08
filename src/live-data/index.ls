Pointer = require \./pointer
Base    = require \./base
Cell    = require \./cell
KV      = require \./kv

live = exports

live.Base = Base

live.KV = KV
live.kv = KV

live.Cell = Cell
live.cell = Cell

live.Pointer = Pointer
live.pointer = Pointer

if global[\window]?
	window.live = live