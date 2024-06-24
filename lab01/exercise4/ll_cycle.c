#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    node *slow = head;
    node *fast = head;

    while (fast != NULL && fast->next != NULL) {
        slow = slow->next;          // move slow pointer one step
        fast = fast->next->next;    // move fast pointer two steps

        if (slow == fast) {
            return 1; // Cycle detected
        }
    }

    return 0; // No cycle
}
