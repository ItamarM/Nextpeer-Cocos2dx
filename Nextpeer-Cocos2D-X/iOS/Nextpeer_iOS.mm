//
//  Created by Nextpeer development team.
//  Copyright (c) 2014 Nextpeer, Inc. All rights reserved.
//

#import "platform/CCPlatformMacros.h"

// Any Objective-C++ code must be wrapped in pre-compiler directives to avoid compiler errors on unsupported platforms
#ifndef CC_TARGET_PLATFORM
#error "CC_TARGET_PLATFORM should be defined!!!"
#endif

#import "Nextpeer_iOS.h"
#import "Nextpeer_iOSDelegate.h"
#import "Nextpeer/Nextpeer.h"

#import <Foundation/Foundation.h>

// CCNextpeer
namespace nextpeer
{
    CCNextpeer::CCNextpeer() {}
    CCNextpeer::~CCNextpeer() {}
    CCNextpeer* CCNextpeer::getInstance()
	{
		return Nextpeer_iOS::getInstance();
	}
}

// Nextpeer_iOS
namespace nextpeer
{
    Nextpeer_iOS* Nextpeer_iOS::_sharedInstance = nil;
    
	
    Nextpeer_iOS* Nextpeer_iOS::getInstance()
    {
		#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
			if (_sharedInstance == nil) {
				_sharedInstance = new Nextpeer_iOS();
			}
		#endif
		
        return _sharedInstance;
    }

	Nextpeer_iOS::Nextpeer_iOS()
		: _facebookBridge(nil)
	{
	}
	
	void Nextpeer_iOS::setFacebookBridge(id<NPFacebookBridgeDelegate> bridge)
	{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
		_facebookBridge = bridge;
#endif
	}

    void Nextpeer_iOS::initialize(const char *apiKey)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* key = [NSString stringWithUTF8String:apiKey];
        Nextpeer_iOSDelegate* delegate = [Nextpeer_iOSDelegate sharedInstance];
        
        NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithUnsignedInteger:NPNotificationPosition_BOTTOM],NextpeerSettingNotificationPosition,
                                  [NSNumber numberWithBool:TRUE],
                                  NextpeerSettingObserveNotificationOrientationChange,
                                  nil];
        
        [Nextpeer initializeWithProductKey:key
                               andSettings:settings
                              andDelegates:[NPDelegatesContainer
                                            containerWithNextpeerDelegate:delegate
                                            tournamentDelegate:delegate
											facebookBridgeDelegate:_facebookBridge]];
#endif
    }
    
    void Nextpeer_iOS::launchDashboard()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer launchDashboard];
#endif
    }
    
    void Nextpeer_iOS::pushDataToOtherPlayers(void * pBuffer, uint32_t length)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        if (!pBuffer || !length) return;
        
        [Nextpeer pushDataToOtherPlayers:[NSData dataWithBytes:pBuffer length:length]];
#endif
    }
    
    void Nextpeer_iOS::unreliablePushDataToOtherPlayers(void* pBuffer, uint32_t length)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        if (!pBuffer || !length) return;
        
        [Nextpeer unreliablePushDataToOtherPlayers:[NSData dataWithBytes:pBuffer length:length]];
#endif
    }
    
    void Nextpeer_iOS::reportScoreForCurrentTournament(uint32_t score)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer reportScoreForCurrentTournament:score];
#endif
    }
    
    void Nextpeer_iOS::reportControlledTournamentOverWithScore(uint32_t score)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer reportControlledTournamentOverWithScore:score];
#endif
    }
    
    bool Nextpeer_iOS::isCurrentlyInTournament()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        return [Nextpeer isCurrentlyInTournament];
#else
        return false;
#endif
    }
    
    void Nextpeer_iOS::reportForfeitForCurrentTournament()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer reportForfeitForCurrentTournament];
#endif
    }
    
    uint32_t Nextpeer_iOS::timeLeftInTournament()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        return 0;
#endif
    }
    
    std::string Nextpeer_iOS::getCurrentPlayerId()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NPGamePlayerContainer* playerContainer = [Nextpeer getCurrentPlayerDetails];
        if (!playerContainer) {
            return std::string("no id found");
        }
        
        return std::string([playerContainer.playerId UTF8String]);
#else
        return std::string("");
#endif
    }
    
    std::string Nextpeer_iOS::getCurrentPlayerName()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NPGamePlayerContainer* playerContainer = [Nextpeer getCurrentPlayerDetails];
        if (!playerContainer) {
            return std::string("no name found");
        }
        
        return std::string([playerContainer.playerName UTF8String]);
#else
        return std::string("");
#endif
    }
    
    void Nextpeer_iOS::enableRankingDisplay(bool enableRankingDisplay)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer enableRankingDisplay:enableRankingDisplay];
#endif
    }
    
    void Nextpeer_iOS::reportScoreModifierForRecording(const char* recordingPlayerId, int32_t modifier)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer reportScoreModifier:modifier forRecording:playerId];
#endif
    }
    
    void Nextpeer_iOS::requestPauseRecording(const char* recordingPlayerId)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer requestPauseRecording:playerId];
#endif
        
    }
    
    void Nextpeer_iOS::requestResumeRecording(const char* recordingPlayerId)
    {
        
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer requestResumeRecording:playerId];
#endif
    }
    
    void Nextpeer_iOS::requestStopRecording(const char* recordingPlayerId)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer requestStopRecording:playerId];
#endif
        
    }
    
    void Nextpeer_iOS::requestRewindRecording(const char* recordingPlayerId, uint32_t timeDelta)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer requestRewindRecording:playerId withTimeDelta:timeDelta];
#endif
        
    }
    
    void Nextpeer_iOS::requestFastForwardRecording(const char* recordingPlayerId, uint32_t timeDelta)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* playerId = [NSString stringWithUTF8String:recordingPlayerId];
        [Nextpeer requestFastForwardRecording:playerId withTimeDelta:timeDelta];
#endif
    }
    
    
    void Nextpeer_iOS::registerToSynchronizedEvent(const char* eventName, uint32_t timeout)
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        NSString* event = [NSString stringWithUTF8String:eventName];
        [Nextpeer registerToSynchronizedEvent:event withTimetout:timeout];
#endif
    }
    
    void Nextpeer_iOS::captureMoment()
    {
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        [Nextpeer captureMoment];
#endif
    }
}