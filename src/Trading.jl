module Trading
using Reexport

@reexport using Dates
@reexport using TimeSeries
const TimeDate = DateTime
export TimeDate

@reexport using Overseer
using Overseer: AbstractComponent, EntityState
using Overseer: update, ensure_component!

using LinearAlgebra
using HTTP
using HTTP.WebSockets
using HTTP.WebSockets: isclosed
using JSON3
using BinaryTraits
using BinaryTraits.Prefix: Can, Cannot, Is, IsNot
using Base.Threads
using HTTP: URI
using EnumX
using UUIDs
using ProgressMeter
using PrettyTables
using Statistics

include("utils.jl")
include("rb_tree.jl")
include("tree_component.jl")
include("assets.jl")
include("Components/core.jl")
include("Components/indicators.jl")
include("Components/portfolio.jl")
include("timearrays.jl")
include("datacache.jl")
include("brokers.jl")
include("asset_ledger.jl")
include("trader.jl")

include("account.jl")
include("running.jl")
include("bars.jl")
include("orders.jl")
include("trades.jl")
include("quotes.jl")
include("time.jl")

include("Systems/core.jl")
include("Systems/indicators.jl")
include("Systems/portfolio.jl")
include("Systems/asset_ledger.jl")

export Stock, Crypto
export Trader, BackTester, start, stop, stop_main, stop_trading, stop_data
export AlpacaBroker, HistoricalBroker
export bars, quotes, trades

function __init__()
    return init_traits(@__MODULE__)
end

module Indicators
    using ..Trading: SMA, EMA, MovingStdDev, RSI, Bollinger, Sharpe
    export SMA, EMA, MovingStdDev, RSI, Bollinger, Sharpe
end

module Basic
    using ..Trading: Open, High, Low, Close, Volume, TimeStamp, LogVal, Difference,
                     RelativeDifference
    export Open, High, Low, Close, Volume, TimeStamp, LogVal, Difference, RelativeDifference
end

module Portfolio
    using ..Trading: Purchase, Sale, Position, PortfolioSnapshot, Filled, OrderType,
                     TimeInForce,
                     current_position, current_cash, current_purchasepower,
                     pending_orders
    export Purchase, Sale, Position, PortfolioSnapshot, Filled, OrderType, TimeInForce,
           current_position, current_cash, current_purchasepower, pending_orders
end

module Strategies
using ..Trading: Strategy, new_entities, reset!, current_price, prev, spread,
                 latest_quote, limit_quantity, Ask, Bid, Trade
export Strategy, new_entities, reset!, current_price, prev, spread, latest_quote,
       limit_quantity, Ask, Bid, Trade
end

module Time
using ..Trading: current_time, market_open_close, in_day, previous_trading_day,
                 is_market_open, is_market_close, only_trading
export current_time, market_open_close, in_day, previous_trading_day, is_market_open,
       is_market_close, only_trading
end

module Analysis
    using ..Trading: returns, sharpe, downside_risk, value_at_risk, maximum_drawdown 
    export returns, sharpe, downside_risk, value_at_risk, maximum_drawdown 
end
end
