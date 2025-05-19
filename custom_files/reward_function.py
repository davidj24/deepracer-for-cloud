import numpy as np

def reward_function(params):
    '''
    Example of penalize steering, which helps mitigate zig-zag behaviors
    '''
    
    # Read input parameters
    distance_from_center = params['distance_from_center']
    track_width = params['track_width']
    steering = abs(params['steering_angle']) # Only need the absolute steering angle
    is_crashed = params['is_crashed']
    off_track = params['is_offtrack']
    speed = params['speed'] # Measured in m/s

    if is_crashed or off_track:
        return -1000

    center_reward = distance_from_center / (track_width/2)

    reward = 10*speed * np.exp(-5 * center_reward**2)




    # Steering penality threshold, change the number based on your action space setting
    ABS_STEERING_THRESHOLD = 15

    # Penalize reward if the car is steering too much
    if steering > ABS_STEERING_THRESHOLD:
        reward *= 0.8

    return float(reward)



# The params dictionary for easy reference

# {
#     "all_wheels_on_track": Boolean,        # flag to indicate if the agent is on the track
#     "x": float,                            # agent's x-coordinate in meters
#     "y": float,                            # agent's y-coordinate in meters
#     "closest_objects": [int, int],         # zero-based indices of the two closest objects to the agent's current position of (x, y).
#     "closest_waypoints": [int, int],       # indices of the two nearest waypoints.
#     "distance_from_center": float,         # distance in meters from the track center 
#     "is_crashed": Boolean,                 # Boolean flag to indicate whether the agent has crashed.
#     "is_left_of_center": Boolean,          # Flag to indicate if the agent is on the left side to the track center or not. 
#     "is_offtrack": Boolean,                # Boolean flag to indicate whether the agent has gone off track.
#     "is_reversed": Boolean,                # flag to indicate if the agent is driving clockwise (True) or counter clockwise (False).
#     "heading": float,                      # agent's yaw in degrees
#     "objects_distance": [float, ],         # list of the objects' distances in meters between 0 and track_length in relation to the starting line.
#     "objects_heading": [float, ],          # list of the objects' headings in degrees between -180 and 180.
#     "objects_left_of_center": [Boolean, ], # list of Boolean flags indicating whether elements' objects are left of the center (True) or not (False).
#     "objects_location": [(float, float),], # list of object locations [(x,y), ...].
#     "objects_speed": [float, ],            # list of the objects' speeds in meters per second.
#     "progress": float,                     # percentage of track completed
#     "speed": float,                        # agent's speed in meters per second (m/s)
#     "steering_angle": float,               # agent's steering angle in degrees
#     "steps": int,                          # number steps completed. Each step is roughly 1/15th of a second later
#     "track_length": float,                 # track length in meters.
#     "track_width": float,                  # width of the track
#     "waypoints": [(float, float), ]        # list of (x,y) as milestones along the track center

# }
